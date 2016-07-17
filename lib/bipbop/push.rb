module Bipbop
  module Client
    class Push
      
      PARAMETER_PUSH_QUERY = "pushQuery"
      PARAMETER_PUSH_INTERVAL = "pushInterval"
      PARAMETER_JURISTEK_CALLBACK = "juristekCallback"
      PARAMETER_PUSH_LABEL = "pushLabel"
      PARAMETER_PUSH_AT = "pushAt"
      PARAMETER_PUSH_TRY_IN = "pushTryIn"
      PARAMETER_PUSH_MAX_VERSION = "pushMaxVersion"
      PARAMETER_PUSH_EXPIRE = "pushExpire"
      PARAMETER_PUSH_PRIORITY = "pushPriority"
      PARAMETER_PUSH_ID = "id"
      PARAMETER_PUSH_CALLBACK = "pushCallback"
      
      @ws
      
      def initialize(ws)
        @ws = ws
      end
      
      # Cria um novo PUSH
      def create(label, push_callback, query, parameters)
        @ws.post("INSERT INTO 'PUSH'.'JOB'", parameters.merge({
              PARAMETER_PUSH_LABEL => label,
              PARAMETER_PUSH_QUERY => query,
              PARAMETER_PUSH_CALLBACK => push_callback
            }))
      end
      # Remove PUSH
      def delete(id)
        @ws.post("DELETE FROM 'PUSH'.'JOB'", {"id" => id}).xpath('string(//BPQL//body//id)')
      end
      
      # Abre um documento criado
      def open(id, label = nil)
        @ws.post("SELECT FROM 'PUSH'.'DOCUMENT'", {"id" => id , "label" => label})
      end
      
      # Muda o intervalo do PUSH
      def change_interval(id, interval)
        @ws.post("UPDATE 'PUSH'.'PUSHINTERVAL'", {
            PARAMETER_PUSH_ID => id,
            PARAMETER_PUSH_INTERVAL => interval,
          })
      end
      
      # Muda a versão máxima do PUSH
      def change_max_version(id, max_version)
        @ws.post("UPDATE 'PUSH'.'PUSHMAXVERSION'", {
            PARAMETER_PUSH_ID => id,
            PARAMETER_PUSH_MAX_VERSION => max_version,
          })
      end
      
    end
  end
end
