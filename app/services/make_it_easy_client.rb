class MakeItEasyClient
  class LeadSignUpError < StandardError; end

  API_VERSION = 'v1'

  def create_lead(params)
    HTTParty.post(create_lead_endpoint, body: params)

  rescue HTTParty::Error
    raise LeadSignUpError
  end

  private

  def base_url
    ENV['LEAD_API_URI']
  end

  def api_url
    base_url + "/api/#{API_VERSION}"
  end

  def create_lead_endpoint
    api_url + '/create'
  end
end