FROM mcr.microsoft.com/mssql/server:2019-CU4-ubuntu-16.04
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=Change@123
EXPOSE 1433
RUN mkdir -pv /tmp/scripts
COPY ./scripts/*.sql /tmp/scripts/
COPY ./*.sh /tmp/


