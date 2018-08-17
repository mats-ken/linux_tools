/*

重複するファイルの削除。
コマンドを吐くだけで削除はしない。

*/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>

// Compares last-modified-time and file-sizes.
int cmp_mtime_sizes(const char path1[], const char path2[])
{
	struct stat buf1, buf2;

	stat(path1, &buf1);
	stat(path2, &buf2);

	if (S_ISDIR(buf1.st_mode)) {
		return -1;
	}
	if (S_ISDIR(buf2.st_mode)) {
		return -2;
	}

	if (buf1.st_mtime != buf2.st_mtime) {
		return 1;
	}

	if (buf1.st_size != buf2.st_size) {
		return 2;
	}

	return 0;	// Matched
}

// Compares contents of given files.
int cmp_contents(const char path1[], const char path2[])
{
	FILE*fp1;
	FILE*fp2;
	int result = 1;

	fp1 = fopen(path1, "r");
	if (NULL == fp1) {
		return -1;
	}
	fp2 = fopen(path2, "r");
	if (NULL == fp2) {
		return -2;
	}

	while (1) {
		int c1, c2;
		c1 = fgetc(fp1);
		c2 = fgetc(fp2);

		if (c1 != c2) {
			break;
		}

		if (EOF == c1) {
			result = 0;	// Matched
			break;
		}
	}

	fclose(fp1);
	fclose(fp2);

	return result;
}

int main(int argc, char*argv[])
{
	for (int i = 1; i < argc; i++) {
		for (int j = i + 1; j < argc; j++) {
			if (0 == strcmp(argv[i], argv[j])) {
				continue;
			}
			if (0 == cmp_mtime_sizes(argv[i], argv[j])
			 && 0 == cmp_contents  (argv[i], argv[j])) {
				printf("rm -f \"%s\" # equ \"%s\"\n", argv[i], argv[j]);
				break;
			}
		}
	}

	return EXIT_SUCCESS;
}
