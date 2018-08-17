cd `dirname "${0}"`

(
  for NAME
  do
    find "$NAME" -type d -name '.svn' -prune -o -type f -print
  done
) | sed -e 's#^.*$#"\0"#' | xargs ./cmp_del
