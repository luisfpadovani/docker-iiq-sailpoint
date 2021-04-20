# SailPoint IIQ no Docker

## Sobre
Tendo em vista a necessidade de ter uma forma descomplicada de codificar e testar o IIQ, criamos uma instalação com uma infraestrutura preparada para está ferramenta.

Essa é uma ótima maneira de desenvolver com o IdentityIQ rapidamente. 
Caso você utilize o SSB como ferramenta de BUILD a utilizaçaõ dessa instalação podem ser estendida a seus ambientes produtivos.

## Pré-requisitos
Para o uso dessa instalação devemos seguir os seguintes passos.
1.  Clonar o repositorio na sua estação de trabalho.
2.  Realizar o download aqui https://community.sailpoint.com/ dos seguintes componentes
	- identityiq-8.1.zip
	- identityiq-8.1p2.jar
	- 1_ssb-v6.1.zip

**Link para realizar o download dos aplicativos fakes criados para essa instalação**  
Observe que o IdentityIQ é um código fechado, portanto, primeiro você precisa obter uma licença para o IdentityIQ.

## Configurando Volumes (Opcional)
Para essa instalação foi inserido 3 volumes , altere somente se houver tal necessidade.

> **É recomendado alterar os volumes somente se o seu sistema operacional for WINDOWS, ir para a seção do *CONFIGURANDO .ENV***

## Configurando .ENV (Opcional)
Existe na raiz deste projeto um .ENV, com alguns atributos, caso queira trocar por outros parametros ou mover os diretorios padrões da instalação, somente acessa-lo e editar.

- LDAP_ADMIN_PASSWORD= **Senha para o OpenLDAP criado para simular o aplicativo fake.**
- LDAP_BASE_DN= **Raiz DN do OpenLDAP criado**
- LDAP_ORGANISATION= **Nome da organização**
- LDAP_DOMAIN= **Domain do OpenLDAP**

**É recomendado alterar as variaveis abaixo, caso seu sistema operacional for WINDOWS**

- LDAP_DATA_SCHEMA= **Schema do OpenLdap caso queira adicionar algum atributo**
- LDAP_DATA= **Contas e Grupos do OpenLdap caso queira adicionar uma nova conta ou  grupo** 
- DIRECTORY_TOMCAT_APPLICATION= **Diretorio para um arquivo com dados de identidades fakes**

## Descrição dos contêiners

#### TOMCAT - tomcat:9.0.34-jdk11-openjdk
- Contêiner com o IIQ SailPoint IdentityIQ8.1p2 em execução com OpenJDK e Tomcat 9.
	-  Com um volume para o diretorio /opt/file onde existe um arquivo com algumas identidades fakes. 

------------

#### SQL SERVER - server:2019-CU4-ubuntu-16.04
- Contêiner com o Banco de Dados SQL Server  2019
	-  Para hospedar o DataBase IdentityIQ e IdentityIQPlugin.
	-  Para hospedar o DataBase de dados AppMock para simular um aplicativo fake.

------------

#### OPENLDAP -  osixia/openldap:1.5.0
- Contêiner OpenLDAP com contas para simular um aplicativo fake.
	-  Com um volume para o arquivo **/container/service/slapd/assets/config/bootstrap/schema/attributes.schema** onde existe um schema, caso aja necessidade de adicionar novos atributos a conta. 
	-  Com um volume para o arquivo **/container/service/slapd/assets/config/bootstrap/ldif/custom/adata.ldif** onde existe um ldif, com contas e grupos. 

#### EMAIL - mailhog/mailhog
- Contêiner com um server de e-mail configurado para disparar E-mail's.


## Executando contêiner
Para executar o conteiner só necessita da linha de comando
```
docker-compose up
```