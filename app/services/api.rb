require 'httparty'

class Api
  def self.enqueue(token:, user_id:, acc_name:, partner_name:, name:, business_name:, tel_number:, email:)
    Response.new(
      HTTParty.post(
        url,
        body: body(token, user_id, acc_name, partner_name, name, business_name, tel_number, email),
        headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
      )
    )
  end

  def self.url
    ENV['LEAD_API_URI'] + '/api/v1/create'
  end

  private

  def self.body(token, user_id, acc_name, partner_name, name, business_name, tel_number, email)
    URI.encode_www_form(
      {
        access_token: token,
        pGUID: user_id,
        pAccName: acc_name,
        pPartner: partner_name,
        name: name,
        business_name: business_name,
        telephone_number: tel_number,
        email: email,
        contact_time: Time.now.utc.strftime("%Y-%m-%d %T"),
        notes: '',
        reference: ''
      }
    )
  end

  class Response
    attr_reader :status, :message, :errors

    def initialize(httparty_response)
      @status = httparty_response.code
      parsed_response = httparty_response.parsed_response
      @message = parsed_response['message']
      @errors = parsed_response['errors']
    end
  end
end
