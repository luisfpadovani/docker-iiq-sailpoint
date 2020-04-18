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

#AQUI VAI COPIAR PASTAS E MONTAR IIQ COM AS MUDANÇAS

#GERAR O PACOTE DO IIQ DEFAULT
RUN cd ../ssb && sh build.sh clean war

#MOVE PACOTE CRIADO PARA A PASTA DO TOMCAT
RUN mv ../ssb/build/deploy/identityiq.war  webapps/identityiq.war

