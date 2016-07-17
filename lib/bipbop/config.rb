module Bipbop
  module Client
    class Config
      @@key = '6057b71263c21e4ada266c9d4d4da613'
      def initialize(config)
        @@key = config[:bipbop_api_key]
      end
      def self.key
        @@key
      end
    end
  end
end