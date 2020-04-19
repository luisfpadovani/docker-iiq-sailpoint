#!/bin/bash
echo " eh nois que ta"

arquivo="/tmp/init.txt"

if [ -s "$arquivo" ]
then
    sh /usr/local/tomcat/webapps/identityiq/WEB-INF/bin/iiq console < /tmp/init.txt
    rm -f $arquivo
fi






sh bin/catalina.sh run