class SwaggerClient
  include HTTParty

  base_uri Rails.application.config.lead_api_base_uri
  headers 'Content-Type' => 'application/x-www-form-urlencoded; charset=utf-8'

  def initialize
    @options = {
      credentials: {
        access_token: Rails.application.config.lead_api_access_token,
        pGUID: Rails.application.config.lead_api_pguid,
        pAccName: Rails.application.config.lead_api_paccname,
        pPartner: Rails.application.config.lead_api_ppartner
      }
    }
  end

  def create(body)
    begin
      response = self.class.post('/create',
                                 body: @options[:credentials].merge(body))
    rescue
      # notify error catcher like NewRelic or Honeybadger
      return
    end
    response&.parsed_response
  end
end
