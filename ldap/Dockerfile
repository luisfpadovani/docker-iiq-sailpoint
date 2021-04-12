FROM osixia/openldap
LABEL maintainer="Luis Padovani <luisfpadovani@outlook.com>"
#FOR MORE INFORMATION ACESS https://github.com/osixia/docker-openldap

#ADD DATABASE USER MOCK FOR LDAP
ADD ldif/* /container/service/slapd/assets/config/bootstrap/ldif/*

#ADD EXTENDS ATTRIBUTES LDAP, IF YOU DON'T NEED OF ATTRIBUTES, REMOVE THIS LINE
ADD schema/* /container/service/slapd/assets/config/bootstrap/schema/*



