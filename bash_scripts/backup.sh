TGT=$1
DST=.

DATE=`date +%Y-%m-%d_%H-%M`


find $TGT -type f -mtime  -4 > 4d.txt
find $TGT -type f -mtime  -9 > 9d.txt
find $TGT -type f -mtime -15 > 2w.txt
find $TGT -type f -mtime -65 > 8w.txt

echo 4-d ; cat 4d.txt | xargs tar uf $DST/tmp.tar      ; mv $DST/tmp.tar $DST/$TGT-${DATE}_4d.tar ; tar tf $DST/$TGT-${DATE}_4d.tar | wc -l ; cat 4d.txt | wc -l
echo 9-d ; cat 9d.txt | xargs tar uf $DST/tmp.tar      ; mv $DST/tmp.tar $DST/$TGT-${DATE}_9d.tar ; tar tf $DST/$TGT-${DATE}_9d.tar | wc -l ; cat 9d.txt | wc -l
echo 2-w ; cat 2w.txt | xargs tar uf $DST/tmp.tar      ; mv $DST/tmp.tar $DST/$TGT-${DATE}_2w.tar ; tar tf $DST/$TGT-${DATE}_2w.tar | wc -l ; cat 2w.txt | wc -l
echo 8-w ; cat 8w.txt | xargs tar uf $DST/tmp.tar      ; mv $DST/tmp.tar $DST/$TGT-${DATE}_8w.tar ; tar tf $DST/$TGT-${DATE}_8w.tar | wc -l ; cat 8w.txt | wc -l
echo all ;                    tar cf $DST/tmp.tar $TGT ; mv $DST/tmp.tar $DST/$TGT-${DATE}_all.tar

rm -f 4d.txt \
      9d.txt \
      2w.txt \
      8w.txt
