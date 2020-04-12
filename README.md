Repositorio com o intuito de facilitar o uso no desenvolvimento da ferramenta IIQ da Sailpoint

------------
<h4>Sobre </h4>
<p>Tendo em vista a necessidade de ter uma forma de codificar e testar o IIQ, inserimos ela dentro do docker.
Foi desenvolvido um compose com dois dockerfile para criação do ambiente inicial do produto.</p>

------------


<h4>Pastas </h4>
<b>/sqlserver/scripts/</b> => Pasta responsavel por servir de repositorio de scripts de banco de dados </br>
<b>/tomcat/arquivo_padrao/</b> => Pasta responsavel por conter identityiq.war e ssb.zip</br>
<b>/tomcat/codigo_iiq/custom</b> => Pasta responsavel por conter todos os codigos desenvolvidos na estrutura do SSB</br>
<b>/tomcat/codigo_iiq/web</b> => Pasta responsavel por conter todos os codigos do produto alterado</br>
------------
<h4>Mode de uso</h4>
<p> Disponibilizar a estrutura dentro de uma pasta, executar o comando</p>

```yaml
docker-compose up
```
------------
Acessar a url:  http://localhost:8080/identityiq/

<b>Utilizar usuário e senha default do pacote</b>



------------
<h4>Desenvolvidor por </h4>
<b>Luis Padovani</b> @luisfpadovani <br/>
<b>Vinicius Bezerra</b> @vinbeze
