# frozen_string_literal: true

module Api
  class ClientError < StandardError
    CONFIG = Rails
      .application
      .config_for('api_client')
      .with_indifferent_access

    def initialize(msg='Unsuccessful API call', method: nil, uri: nil, params: {}, status: nil)
      params_string = params
        .with_indifferent_access
        .except(*CONFIG[:secret_params])
        .collect {|param, value| "#{param}: #{value}"}
        .join(', ')
      message = msg
      message += ", method: #{method}" if method.present?
      message += ", uri: #{uri}" if uri.present?
      message += ", params: (#{params_string})" if params_string.present?
      message += ", status: #{status}" if status.present?
      super(message)
    end
  end
end
