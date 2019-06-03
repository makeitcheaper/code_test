# frozen_string_literal: true

class LeadAPI
  Result = Struct.new(:errors, keyword_init: true)

  def initialize(params)
    @params = params
  end

  def save
    response = post_request
    errors = errors_from_response(response)
    Result.new(errors: errors)
  end

  private

  attr_reader :params

  def post_request
    uri = URI(api_uri)
    request = Net::HTTP::Post.new(uri)
    request.set_form_data(form_data)

    Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end
  end

  def errors_from_response(response)
    json = parse_response(response)

    if response.code == 201
      []
    else
      json['errors'] || [json['message']]
    end
  end

  def parse_response(response)
    JSON.parse(response.body)
  end

  def api_uri
    Rails.configuration.lead_api_base_uri + '/api/v1/create'
  end

  def form_data
    {
      access_token: access_token,
      pGUID: pguid,
      pAccName: paccname,
      pPartner: ppartner,
      name: params[:name],
      business_name: params[:business_name],
      telephone_number: params[:telephone_number],
      email: params[:email],
      contact_time: contact_time,
      notes: params[:notes],
      reference: params[:reference]
    }
  end

  def access_token
    Rails.configuration.lead_api_access_token
  end

  def pguid
    Rails.configuration.lead_api_pguid
  end

  def paccname
    Rails.configuration.lead_api_paccname
  end

  def ppartner
    Rails.configuration.lead_api_ppartner
  end

  def contact_time
    params[:contact_time].to_s.gsub('T', ' ')
  end
end
