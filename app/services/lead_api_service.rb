class LeadApiService
  include HTTParty
  base_uri ENV['LEAD_API_URI']

  attr_reader :lead

  def initialize(lead)
    @lead = lead
  end

  def call
    self.class.post('/api/v1/create', body: lead.as_json)
  end
end
