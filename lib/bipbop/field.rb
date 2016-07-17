module Bipbop
  module Client
    #Informações a respeito de um campo da BIPBOP
    class Field
      
      @dom_node
      @dom
      @table
      @database
    
      def initialize(table, database, dom_node, dom)
        @table = table
        @database = database
        @dom = dom
        @dom_node = dom_node
      end
      def name
        @dom_node['name']
      end
      
      #Informação do XML a respeito de um campo
      def get(attribute)
        @dom_node[attribute]
      end
      
      #Lista de opções do campo
      def options
        self.read_options(@dom_node.xpath(".//option"))
      end
      
      # Lista de opções do grupo
      def group_options
        @dom_node.xpath(".//optgroup").to_a.map { |node|  
          [node['value'], self.read_options(node.xpath(".//option"))]
        }
      end
      
      #Lista de opções disponíveis
      protected 
      def read_options(node_list)
        node_list.to_a.map { |obj|  
          [obj['value'], obj.text]
        }
      end
    end
  end
end
