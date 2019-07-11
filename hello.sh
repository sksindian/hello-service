#!/bin/bash
# chkconfig: 345 20 80
# description: Hello Application
case "$1" in
start)
   export set FLASK_APP=hello.py; flask run -h 0.0.0.0 -p 8080 >> /var/log/hello.log 2>&1 &
   echo $! > /var/run/hello
   ;;
stop)
   kill `cat /var/run/hello`
   rm /var/run/hello
   ;;
restart)
   $0 stop
   $0 start
   ;;
status)
   if [ -e /var/run/hello ]; then
       echo "hello is running, pid=`cat /var/run/hello`"
   else
       echo "hello is NOT running"
       exit 1
   fi
   ;;
*)
   echo "Usage: $0 {start|stop|status|restart}"
esac
