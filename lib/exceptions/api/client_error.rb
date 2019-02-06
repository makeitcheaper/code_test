# frozen_string_literal: true

module Api
  class ClientError < StandardError
    CONFIG = Rails
      .application
      .config_for('api_client')
      .with_indifferent_access

    attr_reader :response

    def initialize(msg='Unsuccessful API call', method: nil, uri: nil, query: {}, body: {}, status: nil, response: nil)
      @response = response
      query_string = params_to_string(query)
      body_string = params_to_string(body)
      message = msg
      message += ", method: #{method}" if method.present?
      message += ", uri: #{uri}" if uri.present?
      message += ", query: (#{query_string})" if query_string.present?
      message += ", body: (#{body_string})" if body_string.present?
      message += ", status: #{status}" if status.present?
      super(message)
    end

    def response?
      !response.nil?
    end

    private

    def params_to_string(params)
      params
        .with_indifferent_access
        .except(*CONFIG[:secret_params])
        .collect {|param, value| "#{param}: #{value}"}
        .join(', ')
    end
  end
end
