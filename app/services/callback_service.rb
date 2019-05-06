# frozen_string_literal: true

class CallbackService
  attr_accessor :customer, :response, :error

  def self.call(customer)
    new(customer).call
  end

  def initialize(customer)
    @customer = customer
    @response = nil
    @error = { message: nil, code: nil }
  end

  def call
    @response = Callback::Client.enqueue(customer)
    handle_error(@response.parsed_response['message'], @response.code) unless @response.success?
    self
  end

  def error?
    error && error[:message]
  end

  def handle_error(message, code)
    @error = { message: message, code: code }
  end
end
