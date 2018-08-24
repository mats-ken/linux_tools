F="$1.tar"

tar cf "$F" "$1"
head -c 3 < "$F" > "$1-sp1"
tail -c $((`wc -c < "$F"` - 3)) < "$F" > "$1-sp2"
cat "$1-sp1" "$1-sp2" > "$1-sptmp"
diff "$F" "$1-sptmp"
tar df "$1-sptmp"
rm "$1-sptmp"
