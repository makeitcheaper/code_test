module LeadApi
  module Error
    class Authorization < StandardError
      def initialize
        super('unauthorized')
      end
    end
  end
end
