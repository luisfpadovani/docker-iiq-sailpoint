FROM tomcat:9.0.34-jdk11-openjdk


RUN apt-get -y update  && \
        apt-get install -y curl && \
        apt-get install -y telnet && \
        apt-get install -y vim && \
        apt-get install -y zip

RUN mkdir webapps/identityiq/
COPY ./identityiq.war webapps/identityiq/
COPY ./ssb.zip ../
RUN unzip ../ssb.zip -d ../ssb/
RUN rm ../ssb.zip

RUN cd webapps/identityiq && jar -xf identityiq.war
RUN rm webapps/identityiq/identityiq.war
RUN chmod +x webapps/identityiq/WEB-INF/bin/iiq
RUN rm webapps/identityiq/WEB-INF/classes/iiq.properties
COPY iiq.properties webapps/identityiq/WEB-INF/classes/





