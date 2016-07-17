module Bipbop
  module Client
    class NameByCpfCnpj
      # birtyday Time
      def self.evaluate(cpf_cnpj, birtyday = nil)
        cpf = Bipbop::Client::CpfCnpjValidation::Cpf.new
        cnpj = Bipbop::Client::CpfCnpjValidation::Cnpj.new

        if (cpf.is_valid?(cpf_cnpj)) 
          if (!birtyday.instance_of? Time)
            raise raise Bipbop::Client::Exception.new("É necessário informar a data de nascimento para consultar um CPF.")
          end
        elsif (!cnpj.is_valid?(cpf_cnpj)) 
          raise Bipbop::Client::Exception.new("O documento informado não é um CPF ou CNPJ válido.")
        end
        
        if (birtyday.instance_of? Time)
          birtyday = birtyday.strftime('%d-%m-%Y')
        end 
        
        Bipbop::Client::Webservice.new.post("SELECT FROM 'BIPBOPJS'.'CPFCNPJ'", {
            "documento" => cpf_cnpj,
            "nascimento" => birtyday
          }).xpath('string(//BPQL//body//nome//.)')
      end
    end
  end
end
