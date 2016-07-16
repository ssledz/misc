#! /bin/bash

SERVER_PATH=/home/ssledz/servers/mysql
DIR=`pwd`
SCRIPTNAME=$0
EXITCODE=0


function mysqls() {
   pgrep -f mysqld
}

function showMysqls() {
  pgrep -fl mysqld
}

function status() {
  echo
  echo "MySQL 5.5 processes:"
  showMysqls
  echo
  mysqls_count=`mysqls | wc -l`
  if [ "$mysqls_count" -ge 2 ]
  then
    echo "MySQL 5.5 is running"
  else
    echo "MySQL 5.5 is not running"
  fi
}

function wait_for_stop() {
  i=0
  while [ `mysqls | wc -l` -gt 0 ]
  do 
    showMysqls
    echo
    sleep 1 
    i=$((i+1))
    if [ "$i" = "10" ]
    then
      killMysqls
      break
    fi
  done
  showMysqls
}

function killMysqls() {
  for pid in `pgrep -f mysql-5.5`
  do
   if [ "`pwdx $pid | grep $DSR_SERVER_PATH | wc -l`" -eq 1 ]
   then
     echo killing $pid
     kill -9 $pid
   fi

  done
}


function start() {

./bin/mysqld_safe --defaults-file=$SERVER_PATH/my.cnf --ledir=$SERVER_PATH/bin &

}

function stop() {

./bin/mysqladmin -u root -h 127.0.0.1 -P 3306 shutdown -ptest

}

case "$1" in
  start)
    cd $SERVER_PATH
    start
    cd $DIR
    ;;
  stop)
    cd $SERVER_PATH
    stop
    cd $DIR
    ;;
  status)
    cd $SERVER_PATH
    status 
    cd $DIR
    ;;
  restart)
    cd $SERVER_PATH
    stop
    wait_for_stop
    start
    cd $DIR
    ;;
 cmd)
   cd $SERVER_PATH
   ./bin/mysqladmin -u root -h 127.0.0.1 -P 3306 -ptest $2
   cd $DIR
   ;;
 console)
   cd $SERVER_PATH
   ./bin/mysql -u root -h 127.0.0.1 -P 3306 -ptest
   cd $DIR
   ;;
 test)
  cd $SERVER_PATH
  cd ./mysql-test ; perl mysql-test-run.pl
  cd $DIR
  ;;
  *)
    echo "Usage: $SCRIPTNAME {start|stop|status|restart|cmd|console|test}" >&2
    exit 3
    ;;
esac

