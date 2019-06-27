# -----------
# From Environment

# access_token
# pGUID
# pAccName
# pPartner

# -----------
# From User

# name - Firstname + Lastname (max 100 chars)
# business_name - Business name (max 100 chars)
# telephone_number - Valid UK phone number (max 13 chars)
# email - Email (max 80 chars)

# -----------
# Optional

# contact_time - Datetime e.g: "2016-11-27 13:45:30" or "2016-11-27 13:45"
# notes - (max 255 chars)
# reference - (max 50 chars)

class MakeItCheaperService
  class ApiError < StandardError; end
  class UnhandledResponse < StandardError; end

  include HTTParty

  base_uri ENV.fetch('LEAD_API_URI')

  class << self
    def save_lead(lead)
      response = post(
        '/api/v1/create',
        query: lead.as_json.merge(api_options)
      )

      parsed_response_body = JSON.parse(response.body)

      case response.code
      when 201
        true
      when 400
        # TODO: add some validation errors on lead object


        lead.errors.add(:field, message)

        false
      when 401, 500
        raise ApiError.new(
          parsed_response_body.fetch('message', response.message)
        )
      else
        raise UnhandledResponse.new("status: #{response.code}")
      end
    end

    private

    def access_token
      ENV.fetch('LEAD_API_ACCESS_TOKEN')
    end

    def api_options
      {
        access_token: access_token,
        pGUID: pGUID,
        pAccName: pAccName,
        pPartner: pPartner,
      }
    end

    def pGUID
      ENV.fetch('LEAD_API_PGUID')
    end

    def pAccName
      ENV.fetch('LEAD_API_PACCNAME')
    end

    def pPartner
      ENV.fetch('LEAD_API_PPARTNER')
    end
  end
end
