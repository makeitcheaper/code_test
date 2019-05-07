# frozen_string_literal: true

class CallbackService
  attr_accessor :customer, :response, :response_code

  def self.call(customer)
    new(customer).call
  end

  def initialize(customer)
    @customer = customer
    @response = nil
    @response_code = nil
  end

  def call
    @response = Callback::Client.enqueue(customer)
    @response_code = @response.code
    self
  end

  def error?
    [400, 401, 501].include?(@response_code)
  end
end
