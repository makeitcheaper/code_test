require 'httparty'

class Api
  def self.enqueue(token:, user_id:, acc_name:, partner_name:, name:, business_name:, tel_number:, email:)
    path = '/api/v1/create'
    url = ENV['LEAD_API_URI'] + path
    resp = HTTParty.post(
      url,
      body: body(token, user_id, acc_name, partner_name, name, business_name, tel_number, email),
      headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
    ).tap {|r| puts ">>>>> response: #{r.parsed_response}"}
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
end
