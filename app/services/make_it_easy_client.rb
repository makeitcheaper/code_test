class MakeItEasyClient
  API_VERSION = 'v1'

  def create_lead(params)
    HTTParty.post(create_lead_endpoint, body: params, timeout: 3)

  rescue HTTParty::Error, SocketError, Net::OpenTimeout => e
    # In the event of this occuring it would be sensible to log the error
    # to a monitoring provider like Airbrake. I decided not to implement this
    # due to time restrictions and it felt like overkill for a technical test.
    return OpenStruct.new(success?: false, errors: { make_it_easy: ['API call failed'] })
  end

  private

  def create_lead_endpoint
    api_url + '/create'
  end

  def base_url
    ENV['LEAD_API_URI']
  end

  def api_url
    base_url + "/api/#{API_VERSION}"
  end
end