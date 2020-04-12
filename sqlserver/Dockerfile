FROM mcr.microsoft.com/mssql/server:2019-CU4-ubuntu-16.04

#ACEITAR TERMOS E CONDIÇÕES DO SQL
ENV ACCEPT_EULA=Y

#SENHA DO SA
ENV SA_PASSWORD=Change@123

EXPOSE 1433

#CRIAÇÃO DA PASTA PARA SCRIPTS
RUN mkdir -pv /tmp/scripts

#COPIAR SCRIPTS DA MAQUINA PARA DENTRO DA IMAGEM
COPY ./scripts/*.sql /tmp/scripts/
COPY ./*.sh /tmp/


