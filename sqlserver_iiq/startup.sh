#!/bin/bash
sleep 40s
echo "********************" 
echo "START EXEC STARTUP.SH"
echo "********************" 
conta=0
pathScripts="/tmp/scripts/"
for entry in `ls $pathScripts | sort -n`; do
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Change@123 -i ${pathScripts}${entry} -o /tmp/execucao${conta}.txt
    conta=$(($conta+1))
done
rm -rf ${pathScripts}*
echo "********************" 
echo "END EXEC  STARTUP.SH"
echo "********************" 