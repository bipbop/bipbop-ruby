require 'curl'
require 'nokogiri'
require 'open-uri'

module Bipbop
  module Client
    class Webservice 
  
      ENDPOINT = "https://irql.bipbop.com.br/";
      REFERRER = "https://juridicocorrespondentes.com.br/";
      PARAMETER_QUERY = "q";
      PARAMETER_APIKEY = "apiKey";
      
      # Inicializa a API
      # @param string $apiKey Chave de acesso da BIPBOP
      # @return Nokogiri::XML::Document
  
      def post (query, parameters = {})
    
        curl = CURL.new({'cookies_enable' => false})
        response = curl.post(ENDPOINT, parameters.merge({
              PARAMETER_QUERY =>  query,
              PARAMETER_APIKEY => Bipbop::Client::Config.key
            }));
        document = Nokogiri::XML(response)
        self::assert(document)
     
        document
    
      end
      # Realiza um assertion do documento
      def assert(doc)
        node = doc.xpath('//BPQL//header//exception')
      
        if node.length > 0
          node_exception = node.first
          source = node_exception["source"]
          code = node_exception["code"]
          id = node_exception["id"]
          pushable = (node_exception["pushable"] || node_exception["push"]) === true
          message = node_exception.text
          
          exception = Bipbop::Client::Exception.new("[%s:%s/%s] %s" % [code, source, id, message, pushable])
          exception.set_attributes(code, source, id, message, pushable)
          
          raise exception
        
        end
      end
    end
  end
end