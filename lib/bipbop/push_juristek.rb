module Bipbop
  module Client
    class PushJuristek < Bipbop::Client::Push
      
      PARAMETER_PUSH_JURISTEK_CALLBACK = "juristekCallback"
      PARAMETER_PUSH_JURISTEK_QUERY = "data"
      
      # Cria um novo PUSH
      def create(label, push_callback, query, parameters) 
        data = Array.new
        if !parameters.nil? && !parameters.empty?
          parameters.each { |key, value| 
            data.push("'%s' = '%s'" % [key.to_s.gsub(/\'/i, ''), value.to_s.gsub(/\'/i,'')])
          }
          query += ((query =~ /where/i) == nil ? ' WHERE ' : '' ) + data.join(' AND ')
          
          @ws.post("INSERT INTO 'PUSHJURISTEK'.'JOB'", parameters.merge({
                PARAMETER_PUSH_LABEL => label,
                PARAMETER_PUSH_QUERY => "SELECT FROM 'JURISTEK'.'PUSH'",
                PARAMETER_PUSH_JURISTEK_QUERY => query,
                PARAMETER_PUSH_JURISTEK_CALLBACK => push_callback
              }))
        end      
      end
    end
  end
end
