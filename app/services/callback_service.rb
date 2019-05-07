# frozen_string_literal: true

# CallbackService: Logic for making the call to Callback::Client.
class CallbackService
  attr_accessor :customer, :response, :response_code

  # Class method to initalize the service and call the 'call' method.
  def self.call(customer)
    new(customer).call
  end

  def initialize(customer)
    @customer = customer
    @response = nil
    @response_code = nil
  end

  # Enqueue a request to the API.
  # Store the response object and response code.
  def call
    @response = Callback::Client.enqueue(customer)
    @response_code = @response.code
    self
  end

  def error?
    [400, 401, 501].include?(@response_code)
  end
end
