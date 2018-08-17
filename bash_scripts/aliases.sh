alias la='ls -a'
alias ll='ls -l'


alias up='svn up'
alias re='svn revert -R'
alias cu='svn cleanup'


alias allm="find -type f -iname \*.m | sed -e 's#.*#\"\0\"#g'"
alias allpy="find -type f -iname \*.py | sed -e 's#.*#\"\0\"#g'"
alias allcp="find -type f -iname \*.cpp | sed -e 's#.*#\"\0\"#g'"
alias allc="find -type f -iname \*.c | sed -e 's#.*#\"\0\"#g'"
alias allh="find -type f -iname \*.h | sed -e 's#.*#\"\0\"#g'"
alias allch="find -type f -iname \*.[ch] | sed -e 's#.*#\"\0\"#g'"
alias allcph="find -type f -iname \*.cpp -or -iname \*.h | sed -e 's#.*#\"\0\"#g'"
alias allccph="find -type f -iname \*.cpp -or -iname \*.[ch] | sed -e 's#.*#\"\0\"#g'"


alias allmgrep='allm | xargs grep'
alias allpygrep='allpy | xargs grep'
alias allcpgrep='allcp | xargs grep'
alias allcgrep='allc | xargs grep'
alias allhgrep='allh | xargs grep'
alias allchgrep='allch | xargs grep'
alias allcphgrep='allcph | xargs grep'
alias allccphgrep='allccph | xargs grep'


alias keycon='sudo dpkg-reconfigure keyboard-configuration'
