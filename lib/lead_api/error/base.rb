module LeadApi
  module Error
    class Base < StandardError
      attr_reader :message

      def initialize(message = '')
        @message = "LeadAPI Error: #{message}"
      end
    end
  end
end
