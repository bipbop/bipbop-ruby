module Bipbop
  module Client
    class ServiceDiscoveryJuristek < Bipbop::Client::ServiceDiscovery
      
      PARAMETER_OAB = "OAB"

      def self.factory(ws, parameters = {})
        ServiceDiscoveryJuristek.new(ws, ws.post("SELECT FROM 'JURISTEK'.'INFO'", parameters.merge(
              'data' => !parameters[PARAMETER_OAB].nil? && parameters[PARAMETER_OAB] != nil ? 
                "SELECT FROM 'INFO'.'INFO'" : "SELECT FROM 'INFO'.'INFO' WHERE 'TIPO_CONSULTA' = 'OAB'"
            )))
      end
    end
  end
end
