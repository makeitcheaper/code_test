module LeadApi
  module Error
    class Validation < StandardError
      attr_reader :errors

      def initialize(errors = [])
        super('Validation')
        @errors = errors
      end
    end
  end
end
