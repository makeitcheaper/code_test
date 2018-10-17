class MakeItEasyClient
  API_VERSION = 'v1'

  def create_lead(params)
    response = HTTParty.post(create_lead_endpoint, body: request_params(params), timeout: 3)
    if response.code == 400
      OpenStruct.new(success?: false, errors: { make_it_easy: response.parsed_response["errors"] })
    else
      response
    end

  rescue HTTParty::Error, SocketError, Net::OpenTimeout => e
    # In the event of this occuring it would be sensible to log the error
    # to a monitoring provider like Airbrake. I decided not to implement this
    # due to time restrictions and it felt like overkill for a technical test.
    return OpenStruct.new(success?: false, errors: { make_it_easy: ['API call failed. Please try again'] })
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

  def request_params(params)
    params.merge!(access_params)
  end

  def access_params
    {
      access_token: ENV['LEAD_API_TOKEN'],
      pGUID: ENV['LEAD_API_PGUID'],
      pAccName: ENV['LEAD_API_PACCNAME'],
      pPartner: ENV['LEAD_API_PPARTNER']
    }
  end
end