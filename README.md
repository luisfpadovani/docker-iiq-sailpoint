Repositorio com o intuito de facilitar o uso no desenvolvimento da ferramenta IIQ da Sailpoint

------------
<h4>Sobre </h4>
<p>Tendo em vista a necessidade de ter uma forma de codificar e testar o IIQ, inserimos ela dentro do docker.
Foi desenvolvido um compose com dois dockerfile para criação do ambiente inicial do produto.</p>

------------


<h4>Pastas </h4>
<b>/sqlserver/scripts/</b> => Pasta responsavel por servir de repositorio de scripts de banco de dados,neácessrio realizar a inserção dos scripts de forma crescent. Exe: 1-ScriptEstrutural.sql , 2-ScriptExemplo.sql, 3-ScriptExemplo.sql, etc... </br>
<b>/tomcat/arquivo_padrao/</b> => Pasta responsavel por conter ssb.zip. Necessário configurar o SSB,  contendo toda a estrutura pronta para o primeiro build do pacote. Exe: docker.iiq.properties com usuario e senha, build.properties configurado com a versão do pacote, zip do pacote dentro da pasta ga.</br>
<b>/tomcat/codigo_iiq/custom</b> => Pasta responsavel por conter todos os codigos desenvolvidos na estrutura do SSB</br>
<b>/tomcat/codigo_iiq/web</b> => Pasta responsavel por conter todos os codigos do produto alterado</br>
------------
<h4>Mode de uso</h4>
<p> Depois de disponibilizar o SSB.ZIP dentro do diretorio correto (e com todas esfpecificaçes), executar o comando:</p>

```yaml
docker-compose up
```
------------
Acessar a url:  http://localhost:8080/identityiq/

<b>Utilizar usuário e senha default do pacote</b>



------------
<h4>Desenvolvidor por </h4>
<b>Luis Padovani</b> @luisfpadovani <br/>