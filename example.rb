require 'bipbop'

Bipbop::Client::Config.new({:bipbop_api_key => '6057b71263c21e4ada266c9d4d4da613'})

webservice = Bipbop::Client::Webservice.new
service_discovery = Bipbop::Client::ServiceDiscovery.factory(webservice)

puts "\n\n== Listando todos os databases ==\n\n"
service_discovery.list_databases() { |database_info|  
  database = service_discovery.get_database(database_info.first['name'])
  puts "Available Database: %s\nDescription: %s\nURL: %s\n\n" % [database.name(), database.get("description"), database.get("url")]
}

puts "\n== Listando tabelas de PLACA ==\n\n"
database_placa = service_discovery.get_database('PLACA')
database_placa.list_tables() { |table_info|
  table = database_placa.get_table(table_info.first['name'])
  puts "Available Table: %s\nDescription: %s\nURL: %s\n\n" % [table.name(), table.get("description"), table.get("url")]
}

tabela_consulta = database_placa.get_table('CONSULTA')
puts "\n== Listando campos de CONSULTA ==\n\n"

tabela_consulta.get_fields() { |field|  
  puts "Available Field: %s\n\n" % field.name() 
}

puts webservice.post("SELECT FROM 'PLACA'.'CONSULTA'", {
    "placa" => "OGD1557"
})

#PUSH
push = Bipbop::Client::Push.new(webservice)
response = push.create('suaLabel',  '', "SELECT FROM 'PLACA'.'CONSULTA'", {'placa' => 'OGD1557'})

puts response

# pegando o id do push criado
id = response.xpath('//body//id').text
puts id

# abrindo um push criado
puts push.open(id)

# removendo um push
push.delete(id)
