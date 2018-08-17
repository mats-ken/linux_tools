/*

grep -n
をリダイレクトして作ったファイルを編集して、それを元ファイルに反映させるプログラム。行番号を負数にすると行を削除。
マルチファイル正規表現置換でも出来ないようなことをやるのに便利。
条件が揃えば、grep | cut | |./grep_patchとかも可能。
一つのファイルの複数行を変更する場合、同じファイルを何度も作り直すことになるが、そこはご愛敬ということでｗ

Usage:

$ grep -n "#define" *.c | grep DEBUG > tmp.c

$ cat tmp.c
x.c:5:#define DEBUG
y.c:6:#define DEBUG
z.c:7:#define DEBUG

(エディタでtmp.cを編集する)

$ cat tmp.c
x.c:5://#define DEBUG
y.c:6://#define DEBUG
z.c:7://#define DEBUG

$ gcc grep_patch.c -o grep_patch

$ ./grep_patch < tmp.c
[x.c][5][//#define DEBUG]
[y.c][6][//#define DEBUG]
[z.c][7][//#define DEBUG]

*/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define IN stdin
#define ERR stderr

#define BUFMAX 1000

int parse(const char buf[], char name[], int*const line, char sub[])
{
	char* ptr = strchr(buf, ':');
	strncpy(name, buf, ptr - buf);

	ptr++;

	*line = atoi(ptr);
	if (0 == *line) {
		return -1;
	}

	ptr = strchr(ptr, ':');
	if (NULL == ptr) {
		return -2;
	}
	ptr++;

	int last = ptr[strlen(ptr) - 1];
	if (('\r' != last) && ('\n' != last)) {
		return -3;
	}
	strcpy(sub, ptr);

	return 0;
}

int replace(const char name[], const int line, const char sub[])
{
	FILE*in;
	FILE*out;

	char buf  [BUFMAX + 10];
	char name2[BUFMAX + 10];

	in = fopen(name, "r");
	if (NULL == in) {
		return -1;
	}

	strcpy(name2, name);
	strcat(name2, ".new");

	out = fopen(name2, "w");
	if (NULL == out) {
		return -2;
	}

	for (int i = 0; i < abs(line) - 1; i++) {
		if (NULL == fgets(buf, BUFMAX, in)) {
			return -3;
		}
		fputs(buf, out);
	}

	if (NULL == fgets(buf, BUFMAX, in)) {
		return -4;
	}
	if (0 < line) {
		fputs(sub, out);
	} else if (strcmp(buf, sub)) {
		return -5;
	}

	while(1) {
		if (NULL == fgets(buf, BUFMAX, in)) {
			break;
		}
		fputs(buf, out);
	}

	fclose(in);
	fclose(out);

	remove(name);
	rename(name2, name);

	return 0;
}

int main(void)
{
	char buf[BUFMAX + 10];

	while(NULL != fgets(buf, BUFMAX, IN)) {
		char name[BUFMAX + 10]; // file name
		char sub [BUFMAX + 10]; // substitute
		int line;

		if (parse(buf, name, &line, sub) < 0) {
			fprintf(ERR, "Parse error.\n");
		} else if (replace(name, line, sub) < 0) {
			fprintf(ERR, "Replace error.\n");
		}

		sub[strlen(sub) - 1] = '\0';
		printf("[%s][%d][%s]\n", name, line, sub);
	}

	return EXIT_SUCCESS;
}
