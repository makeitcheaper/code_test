module LeadApi
  module Error
    class Server < StandardError
      def initialize(message = '')
        super(message)
      end
    end
  end
end
