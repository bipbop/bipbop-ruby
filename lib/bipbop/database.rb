module Bipbop
  module Client
    class Database
      
      KEY_TABLE_NAME = "name"
      KEY_TABLE_DESCRIPTION = "description"
      KEY_TABLE_URL = "url"
      
      @ws
      @dom_node
      @dom
    
      # Instância um Database
      # @param BIPBOP::Client::Webservice ws
      # @param Nokogiri::XML::Node dom_node
      # @param Nokogiri::XML::Document dom
     
      def initialize(ws, dom_node, dom)
        @ws = ws
        @dom_node = dom_node
        @dom = dom
      end
      
      # Captura o nome do database
      def name
        @dom_node['name']
      end
      
      def list_tables
        @dom_node.xpath("table").each { |node|
          yield [
            KEY_TABLE_NAME => node['name'],
            KEY_TABLE_DESCRIPTION => node["description"],
            KEY_TABLE_URL => node["url"]
          ]
        }
      end
      
      def get_table(name)
        table = @dom_node.xpath(".//table[@name='%s']" % name.gsub(/[^a-z0-9\-_]/i, ''))
        if (table.length == 0) 
          raise Exception, "Can't find that table."
        end
        
        Bipbop::Client::Table.new(@ws, self, table.first, @dom)
        
      end
      
      def get(attribute)
        @dom_node[attribute]
      end
    end
  end
end
