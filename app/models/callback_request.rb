# frozen_string_literal: true

require_relative '../../lib/lead_service'

class CallbackRequest
  include ActiveModel::Model

  attr_accessor(
    :access_token,
    :pGUID,
    :pAccName,
    :pPartner,
    :name,
    :business_name,
    :telephone_number,
    :email,
    :contact_time,
    :notes,
    :reference
  )

  def save
    response = LeadService.create(attributes)

    return true if response.ok?

    add_multiple_errors(response.validation_errors)
    false
  end

  def attributes
    instance_values
  end

  private

  # Having to maintain the set of validatoins in both the Lead API service and
  # in this model would be really annoying so I opted to go for dynamically
  # setting the validation errors. However, this solution would be contingent on
  # a consistant validation error message format, which it looks like we have.
  def add_multiple_errors(validation_errors)
    validation_errors.each do |field, error_messages|
      error_messages.each do |error_message|
        errors.add(field, error_message)
      end
    end
  end
end
