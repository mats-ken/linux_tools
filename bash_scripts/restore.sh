ls *.tar | xargs -n 1
tar xf `ls *all.tar | sort | tail -n 1`
tar xf `ls *.tar | sort | tail -n 1`
