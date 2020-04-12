Repositorio com o intuito de facilitar o uso no desenvolvimento da ferramenta IIQ da Sailpoint

------------
<h4>Sobre </h4>
<p>Tendo em vista a necessidade de ter uma forma de codificar e testar o IIQ, inserimos ela dentro do docker.
Foi desenvolvido um compose com dois dockerfile para criação do ambiente inicial do produto.</p>

------------


<h4>Pastas </h4>
/sqlserver/scripts/ => Pasta responsavel por servir de repositorio de scripts de banco de dados
/tomcat/arquivo_padrao/ => Pasta responsavel por conter identityiq.war e ssb.zip
/tomcat/codigo_iiq/custom => Pasta responsavel por conter todos os codigos desenvolvidos na estrutura do SSB
/tomcat/codigo_iiq/web => Pasta responsavel por conter todos os codigos do produto alterado

<h4>Mode de uso</h4>
<p> Disponibilizar a estrutura dentro de uma pasta, executar o comando</p>

```yaml
docker-compose up
```

Acessar a url:  http://localhost:8080/identityiq/

<b>Utilizar usuário e senha default do pacote</b>


<h4>Desenvolvidor por </h4>
<b>Luis Padovani</b> @luisfpadovani <br/>
<b>Vinicius Bezerra</b> @vinbeze
