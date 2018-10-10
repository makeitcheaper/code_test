class MakeItEasyClient
  API_VERSION = 'v1'

  def create_lead(params)
    HTTParty.post(create_lead_endpoint, body: params, timeout: 3)

  rescue HTTParty::Error, SocketError, Net::OpenTimeout => e
    return OpenStruct.new(success?: false, errors: { make_it_easy: ['API call failed'] })
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