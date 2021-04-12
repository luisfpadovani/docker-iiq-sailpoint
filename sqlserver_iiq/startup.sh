#!/bin/bash
sleep 90s
echo "********************" 
echo "START EXEC STARTUP.SH"
echo "********************" 
contador=1
pathScripts="/tmp/scripts/"
for entry in `ls $pathScripts | sort -n`; do
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Change@123 -i ${pathScripts}${entry} -o /tmp/execucao${contador}.txt
done
rm -rf ${pathScripts}*
echo "********************" 
echo "END EXEC  STARTUP.SH"
echo "********************" 