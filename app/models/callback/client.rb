# frozen_string_literal: true

module Callback
  class Client
    include HTTParty

    base_uri ENV['LEAD_API_URI']

    class << self
      def enqueue(customer)
        query = prepare_query(customer)
        post('/api/v1/create', query: query)
      end

      private

      def prepare_query(customer)
        {
          access_token: ENV['LEAD_API_ACCESS_TOKEN'],
          pGUID: customer.uid,
          pAccName: ENV['LEAD_API_PACCNAME'],
          pPartner: ENV['LEAD_API_PPARTNER'],
          name: customer.name,
          business_name: customer.business_name,
          telephone_number: customer.telephone_number,
          email: customer.email,
          contact_time: Time.now.strftime('%F %T'),
          notes: customer.notes,
          reference: customer.reference
        }
      end
    end
  end
end
