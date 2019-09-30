module LeadApi
  BASE_URL = "#{Rails.configuration.lead_api_base_uri}/api/v1".freeze
  CONFIG = {
    access_token: Rails.configuration.lead_api_access_token,
    pGUID: Rails.configuration.lead_api_pguid,
    pAccName: Rails.configuration.lead_api_paccname,
    pPartner: Rails.configuration.lead_api_ppartner
  }.freeze

  class Base
    include HTTParty
    base_uri BASE_URL

    def initialize
      @params = CONFIG.dup
    end

    private

    def parse_response(response)
      JSON.parse(response.body)
    end
  end
end
