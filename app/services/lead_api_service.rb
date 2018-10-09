class LeadApiService
  include HTTParty
  base_uri ENV['LEAD_API_URI']

  class InternalServerError < StandardError; end
  class BadRequest < StandardError; end
  class UnauthorizedAccessToken < StandardError; end

  attr_reader :lead, :response

  def initialize(lead)
    @lead = lead
  end

  def call
    @response = self.class.post('/api/v1/create', body: lead.as_json)
    raise service_error unless response.success?
  end

  private


  def service_error
    "LeadApiService::#{response.response.message.parameterize(separator: '_').classify}".constantize
  end

  def send_external_request
    self.class.post('/api/v1/create', body: lead.as_json)
  end
end
