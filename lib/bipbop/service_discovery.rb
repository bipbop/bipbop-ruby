module Bipbop
  module Client
    class ServiceDiscovery
      
      @ws
      @list_databases

      KEY_DATABASE_NAME = "name"
      KEY_DATABASE_DESCRIPTION = "description"
      KEY_DATABASE_URL = "url"
      
      def initialize (ws, databases)
        @ws = ws
        @list_databases = databases
      end
      
      def self.factory(ws, parameters = {})
        ServiceDiscovery.new(ws, ws.post("SELECT FROM 'INFO'.'INFO'", parameters))
      end
      
      def list_databases
        @list_databases.xpath("//BPQL//body//database").each { |node| 
          yield [
            KEY_DATABASE_NAME => node["name"],
            KEY_DATABASE_DESCRIPTION => node["description"],
            KEY_DATABASE_URL => node["url"]
          ]
        }      
      end
      
      def get_database(name)
        database = @list_databases.xpath("/BPQL/body/database[@name='%s']" % [name.gsub(/[^a-z0-9]/i, '')])
        if (database.length == 0) 
            raise Exception, "Can't find that database."
        end
        
        Bipbop::Client::Database.new(@ws, database.first, @list_databases)
        
      end
    end
  end
end
