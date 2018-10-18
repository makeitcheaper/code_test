class LeadApi
  include HTTParty


  base_uri "#{ENV["LEAD_API_URI"]}/api/v1"
  # debug_output $stdout
  headers(
    'Content-Type' => 'application/x-www-form-urlencoded',
    'Accept' => 'application/json'
  )

  def post_lead lead
    raise ArgumentError, 'lead not provided' if lead.nil?

    params = {
      name: lead[:full_name],
      business_name: lead[:business_name],
      telephone_number: lead[:phone_number],
      email: lead[:email]
    }

    auth_params = {
      access_token: ENV["LEAD_API_ACCESS_TOKEN"],
      pGUID: ENV["LEAD_API_PGUID"],
      pAccName: ENV["LEAD_API_PACCNAME"],
      pPartner: ENV["LEAD_API_PPARTNER"]
    }

    @response = self.class.post "/create",
      query: params.merge(auth_params)

    unless @response.success?
      raise HTTParty::ResponseError, @response
    end

    true
  end
end
