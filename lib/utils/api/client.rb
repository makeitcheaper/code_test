# frozen_string_literal: true

module Api
  class Client
    RECEIVE_METHODS = %i[get].freeze
    SEND_METHODS = %i[post put patch].freeze

    attr_private_initialize :uri

    def call(method, params={}, headers={})
      if RECEIVE_METHODS.include?(method)
        response = call_receive_method(method, params, headers)
      elsif SEND_METHOD.include?(method)
        response = call_send_method(method, params, headers)
      else
        raise 'HTTP method not supported'
      end
      process_response(response)
    rescue => e
      raise ClientError.new(
        uri: uri,
        params: params,
        status: response.try(:status).presence || e.try(:response).try(:status).presence
      )
    end

    private

    def call_receive_method(method, params={}, headers={})
      Faraday.public_send(method, uri, params, headers)
    end

    attr_implement :call_send_method, %i[method, params, headers]

    def process_response(response)
      raise 'HTTP status unsuccessful' unless response.success?
      raise 'Response string blank' if response.body.blank?
      parsed_json = MultiJson.load(response.body)
      raise 'Rasponse blank' if parsed_json.blank?
      parsed_json.with_indifferent_access
    end
  end
end
