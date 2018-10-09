class CreateLeadService
  include Dry::Transaction
  step :validate
  step :call_api

  def validate(params)
    validation = MakeItEasyValidator.new(params)
    if validation.valid?
      Success(validation.form_inputs)
    else
      Failure(validation.errors)
    end
  end

  def call_api(form_inputs)
    response = MakeItEasyClient.new.create_lead(form_inputs)
    if response.success?
      Success(response)
    else
      Failure(response)
    end
  end
end