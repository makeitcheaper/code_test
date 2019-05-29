# frozen_string_literal: true

require 'net/http'
require 'json'

class LeadService
  class Response
    attr_reader :status, :body

    VALIDATION_ERROR_STATUS = "400"

    def initialize(status, body)
      @status = status
      @body = JSON.parse(body, symbolize_names: true) rescue ''
    end

    def validation_errors
      return {} unless status == VALIDATION_ERROR_STATUS

      body.fetch(:errors, {}).each_with_object(Hash.new([])) do |error, hash|
        field, message = error.match(/^Field '(\S+)' (.+)/)[1..2]

        hash[field.to_sym] += [message]
      end
    end

    def ok?
      status.to_i < 300
    end
  end

  class << self
    def create(attributes)
      params = attributes.merge(base_params)
      body = ''

      response = Net::HTTP.post(request_uri('/create', params), body)

      Response.new(response.code, response.body)
    end

    private

    API_VERSION = 'v1'

    def request_uri(path, params)
      uri = URI(ENV.fetch('LEAD_API_URI') + '/api/' + API_VERSION + path)
      uri.query = URI.encode_www_form(params)

      uri
    end

    def api_uri
      ENV.fetch('LEAD_API_URI') + '/api/' + API_VERSION
    end

    def base_params
      {
        access_token: ENV.fetch('LEAD_API_ACCESS_TOKEN'),
        pGUID: ENV.fetch('LEAD_API_PGUID'),
        pAccName: ENV.fetch('LEAD_API_PACCNAME'),
        pPartner: ENV.fetch('LEAD_API_PPARTNER'),
      }
    end
  end
end
