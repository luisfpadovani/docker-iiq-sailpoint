FROM tomcat:9.0.34-jdk11-openjdk


#INSTALAÇÃO DE PLUGINS DENTRO DA IMAGEM
RUN apt-get -y update  && \
        apt-get install -y curl && \
        apt-get install -y telnet && \
        apt-get install -y vim && \
        apt-get install -y zip

#CRIAÇÃO DA PASTA DO IIQ
RUN mkdir webapps/identityiq/

#COPIAR PACOTE .WAR e SSB DA MAQUINA PARA O CONTAINER
COPY ./arquivos_padrao/identityiq.war webapps/identityiq/
COPY ./arquivos_padrao/ssb.zip ../

#REALIZAR UNZIP DO SSB
RUN unzip ../ssb.zip -d ../ssb/
#REMOVER SSB
RUN rm ../ssb.zip

#INSTALAR .WAR NO CONTAINER
RUN cd webapps/identityiq && jar -xf identityiq.war
#REMOVER WAR
RUN rm webapps/identityiq/identityiq.war

#PERMISSIONAMENTO NA PASTA DO IIQ
RUN chmod +x webapps/identityiq/WEB-INF/bin/iiq
#REMOVER IIQ PROPERTIES PADRÂO
RUN rm webapps/identityiq/WEB-INF/classes/iiq.properties
#SUBSTITUIR IIQ PROPERTIES
COPY ./arquivos_padrao/iiq.properties webapps/identityiq/WEB-INF/classes/

#CRIAÇÃO DA PASTA CUSTOM PARA NOVOS ARTEFATOS
RUN mkdir webapps/identityiq/WEB-INF/custom
COPY ./codigo_iiq/custom/ webapps/identityiq/WEB-INF/custom/
