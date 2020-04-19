FROM tomcat:9.0.34-jdk11-openjdk


#INSTALAÇÃO DE PLUGINS DENTRO DA IMAGEM
RUN apt-get -y update  && \
        apt-get install -y curl && \
        apt-get install -y telnet && \
        apt-get install -y vim && \
        apt-get install -y zip



#COPIAR ARQUIVOS SH PARA DAR START NO CATHALINA
COPY ./*.sh /tmp/
#COPIAR O SSB DA MAQUINA PARA O DOCKER
COPY ./arquivos_padrao/ssb.zip ../
#CRIAR VARIAVEL DE AMBIENTE PARA O CONTAINER CRIAR .WAR
ENV SPTARGET=docker
#REALIZAR UNZIP DO SSB
RUN unzip ../ssb.zip -d ../ssb/
#REMOVER PASTA QUE NÃO SERA MAIS UTILIZADA DO ZIP SSB
RUN rm ../ssb.zip
#DAR PERMISSÂO PARA RODAR O build.sh
RUN chmod -R 777 ../ssb/

#AQUI VAI COPIAR PASTAS E MONTAR IIQ COM AS MUDANÇAS DO DIA A DIA
COPY ./codigo_iiq/config/* ../ssb/config/
COPY ./codigo_iiq/web/* ../ssb/web/

#GERAR O PACOTE DO IIQ DEFAULT
RUN cd ../ssb && sh build.sh clean war
#REALIZA UNZIP DO PACOTE NA PASTA DO TOMCAT
RUN unzip ../ssb/build/deploy/identityiq.war -d webapps/identityiq
#REMOVE WAR PARA DEIXAR O PACOTE MENOR
RUN rm ../ssb/build/deploy/identityiq.war && rm ../ssb/build/deploy/identityiq.war.MD5
#CHMOD PARA O IIQ CONSOLE SER HABILITADO
RUN chmod +x webapps/identityiq/WEB-INF/bin/iiq
#GERAR ARQUIVO PARA REALIZAR O INIT.XML
RUN echo "import /usr/local/tomcat/webapps/identityiq/WEB-INF/config/init.xml" >> /tmp/init.txt
