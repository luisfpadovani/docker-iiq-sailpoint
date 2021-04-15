FROM mcr.microsoft.com/mssql/server:2019-CU4-ubuntu-16.04

ENV ACCEPT_EULA=Y

#PASSWORD  SA
ENV SA_PASSWORD=Change@123

EXPOSE 1433

#CREATE FOLDER SCRIPTS *.SQL
RUN mkdir -pv /tmp/scripts

#COPY SCRIPTS *.SQL FOR CONTAINERS
COPY ./scripts/*.sql /tmp/scripts/

RUN chmod +x /tmp/scripts/

#COPY SCRIPTS *.SH FOR CONTAINERS
COPY ./*.sh /tmp/