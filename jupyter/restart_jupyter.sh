PID=`ps x | grep jupyter-notebook | grep -v grep | cut -c -5`
kill $PID


#export PYTHONPATH='/home/'`whoami`'/venv/venv1/lib/python3.6/site-packages'

cd ~/py-work

NAME=`pwd | sed -e 's#^/##' -e 's#/#_#g' -e 's#[^a-zA-Z0-9_\-]##g'`
LOG=~/jupyter-log-$NAME.txt

touch `whoami`@$NAME

source ~/venv/venv1/bin/activate
jupyter notebook &> $LOG &

sleep 3

IP=`ifconfig | grep inet | grep -v inet6 | grep -v 127.0.0.1 | grep 'inet 10' | cut -f 10 -d ' '`
#IP=`set | grep SSH_CONNECTION | cut -f 3 -d ' '`

URL1=`cat $LOG | grep Copy/paste -a2 | grep http | sed -e 's#^ \+##'`
URL2=`echo $URL1 | sed -e 's#'$HOSTNAME'#'$IP'#'`

echo $URL1
echo $URL2

#deactivate
