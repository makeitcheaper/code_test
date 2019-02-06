# frozen_string_literal: true

module MicLeads
  module V1
    class BaseEndpoint
      protected

      def construct_uri(dom, path)
        domain = dom
        domain += '/' unless domain.ends_with?('/')
        URI(domain) + path
      end
    end
  end
end
