#!/bin/bash
arquivo="/tmp/init.txt"
if [ -s "$arquivo" ]
then
    sh /usr/local/tomcat/webapps/identityiq/WEB-INF/bin/iiq console < $arquivo
    rm -f $arquivo
fi
sh bin/catalina.sh run