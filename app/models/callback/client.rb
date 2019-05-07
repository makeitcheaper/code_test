# frozen_string_literal: true

module Callback
  # Callback::Client connects to the 'Make it Better' API
  # and submits the request for a callback.
  class Client
    include HTTParty

    base_uri ENV['LEAD_API_URI']

    class << self
      # Enqueue a callback
      def enqueue(customer)
        post('/api/v1/create', query: prepare_query(customer))
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
