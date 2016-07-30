# Bipbop Ruby

# Instalação

Simples instalação via ruby gem
``` 
# gem install bipbop-client
```
Biblioteca em Ruby para interação com a Bipbop API. Com ela você pode fazer consulta de dados cadastrais, consulta do Perfil Consumidor para SAC, Correios, placas de veículos entre outras bases. Tudo que você precisa é adquirir uma chave de API válida entrando em contato com a Bipbop.

# Buscando o nome através do CPF/CNPJ

Existe uma classe especial chamada `NameByCPFCNPJ` cujo método estático *evaluate* pode ser usado para consultar o nome através do CPF/CNPJ, passando-se o CPF/CNPJ como string e opcionalmente a data de nascimento como [TIME](http://ruby-doc.org/core-2.2.0/Time.html):

```ruby
puts Bipbop::Client::NameByCpfCnpj.evaluate(cpf, nasc)
```

# Como utilizar

Com uma chave de API válida em mãos você pode interagir com bancos os quais sua chave tem acesso. Nesse repositório você encontrará o arquivo __example.rb__ com o codigo a abaixo.

O primeiro passo é saber quais são esses bancos. Para isso temos a classe `ServiceDiscovery` que usa uma instância de `WebService`, criada a partir de sua chave:

```ruby
require 'bipbop'

Bipbop::Client::Config.new({:bipbop_api_key => # sua chave #})

webservice = Bipbop::Client::Webservice.new
service_discovery = Bipbop::Client::ServiceDiscovery.factory(webservice)

puts "\n\n== Listando todos os databases ==\n\n"
service_discovery.list_databases() { |database_info|  
  database = service_discovery.get_database(database_info.first['name'])
  puts "Available Database: %s\nDescription: %s\nURL: %s\n\n" % [database.name(), database.get("description"), database.get("url")]
}

```

Vamos tomar como exemplo o database __PLACA__ e descobrir quais tabelas podemos consultar e com quais campos:

```ruby
puts "\n== Listando tabelas de PLACA ==\n\n"
database_placa = service_discovery.get_database('PLACA')
database_placa.list_tables() { |table_info|
  table = database_placa.get_table(table_info.first['name'])
  puts "Available Table: %s\nDescription: %s\nURL: %s\n\n" % [table.name(), table.get("description"), table.get("url")]
}

```

Nossa listagem retornou a tabela __CONSULTA__ mas quais serão os campos que podemos usar como parâmetros em nossa consulta? Vamos descobrir:

```ruby
tabela_consulta = database_placa.get_table('CONSULTA')
puts "\n== Listando campos de CONSULTA ==\n\n"

tabela_consulta.get_fields() { |field|  
  puts "Available Field: %s\n\n" % field.name() 
}
```

Nossa busca retornou o campo __placa__.

Com esses dados em mãos torna-se simples montar nossa consulta. Basta utilizarmos o método *post* de `WebService` da seguinte forma:

```php
placa = webservice.post("SELECT FROM 'PLACA'.'CONSULTA'", {
    "placa" => "XXX9999"
});
```

Esse método retorna um [Nokogiri::XML::Document](http://www.rubydoc.info/github/sparklemotion/nokogiri/master/Nokogiri/XML/Document) 

```ruby
// Visualizando as tags do documento retornado
puts placa

// Recuperando a marca do veículo
puts (placa.xpath("string(//BPQL//body//marca/.)"));
```

#PUSH

Criando um __PUSH__

A criação de PUSHES permite captura/monitoramento, sobre uma determinada fonte de dados, através de uma consulta segundo o padrão bpql.

```ruby

push = Bipbop::Client::Push.new(webservice)
response = push.create('suaLabel', 'urlDeCallBack' , "SELECT FROM 'PLACA'.'CONSULTA'", {'placa' => 'XXX0000'})

# pegando o id do push criado
id = response.xpath('//body//id').text

```

Nesse caso para a sua url de callback, será retornado o documento bpql gerado, e são enviados os seguintes parametros no header do server:

```ruby
request["HTTP_X_BIPBOP_VERSION"]
request["HTTP_X_BIPBOP_DOCUMENT_ID"] # Organizar os documentos por este ID #
request["HTTP_X_BIPBOP_DOCUMENT_LABEL"]

```
__ABRINDO__ um PUSH

Com este método é possível visualizar o documento bpql capturado. 

```ruby
puts push.open(id)
```

__REMOVENDO__ um PUSH

Com este método é possível remover determinado PUSH da lista de uma apiKey.

```ruby
push.delete(id)
```

# Mais informações

Para mais informações e aquisição de uma chave de api acesse [http://api.bipbop.com.br](http://api.bipbop.com.br).
