class LeadApiService
  include HTTParty
  base_uri ENV['LEAD_API_URI']

  attr_reader :lead

  def initialize(lead)
    @lead = lead
  end

  def call
    self.class.post('/api/v1/create', body: lead.instance_values.to_json)
  end
end
