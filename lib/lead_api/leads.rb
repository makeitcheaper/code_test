module LeadApi
  class Leads < Base
    def create(attrs = {})
      response = self.class.post(
        '/create',
        multipart: true,
        body: attrs.merge(@params)
      )

      parsed_response = parse_response(response)

      if response.code == 201
        parsed_response
      elsif response.code == 400
        validation_errors = parsed_response[:errors]

        raise LeadApi::Error::Validation.new(validation_errors)
      elsif response.code == 401
        raise LeadApi::Error::Authorization.new
      else
        raise LeadApi::Error::Server.new(parsed_response.message)
      end
    end
  end
end
