module Bipbop
  module Client
    class Exception < Exception
      INVALID_ARGUMENT = 1

      @bipbop_code
      @bipbop_source
      @bipbop_id
      @bipbop_message
      @bipbop_pushable

      def get_bipbop_code
        @bipbop_code
      end

      def get_bipbop_source
        @bipbop_source
      end

      def get_bipbop_id
        @bipbop_id
      end

      def get_bipbop_message
        @bipbop_message
      end

      def get_bipbop_pushable
        @bipbop_pushable
      end

      def set_attributes(code, source, id, message, pushable)
        @bipbop_code = code
        @bipbop_source = source
        @bipbop_id = id
        @bipbop_message = message
        @bipbop_pushable = pushable
      end
    end
  end
end
