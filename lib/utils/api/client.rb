# frozen_string_literal: true

module Api
  class Client
    METHODS_WITH_BODY = %i[post put patch].freeze

    attr_private_initialize :uri

    def call(method, query: {}, body: {}, headers: {})
      response = receive_response(method, query: query, body: body, headers: headers)
      json_hash = process_response(method, response)
      raise 'HTTP status unsuccessful' unless response.success?
      json_hash
    rescue => e

      raise ClientError.new(
        method: method,
        uri: uri,
        query: query,
        body: body,
        status: response.try(:status).presence || e.try(:response).try(:status).presence,
        response: json_hash
      )
    end

    private

    def receive_response(method, query: {}, body: {}, headers: {})
      Faraday.public_send(method) do |request|
        request.url(uri)
        request.params.merge!(query) if query.present?
        request.headers.merge!(headers) if headers.present?
        if body.present?
          raise 'Body parameters not accepted  for this method' unless METHODS_WITH_BODY.include?(method)
          request.headers['Content-Type'] = 'application/x-www-form-urlencoded'
          request.body = body.to_param
        end
      end
    end

    def process_response(method, response)
      raise 'Response string blank' if response.body.blank? 
      parsed_json = MultiJson.load(response.body)
      raise 'Rasponse blank' if parsed_json.blank?
      parsed_json.with_indifferent_access
    end
  end
end
