# frozen_string_literal: true

class SendLead
  include HTTParty
  base_uri Rails.application.config.mic_api_base_uri

  def initialize(lead)
    @lead = lead
  end

  def self.call(lead)
    new(lead).call
  end

  def call
    return false unless lead.valid?

    response = post_lead
    process_response(response)
  end

  private

  attr_reader :lead

  def post_lead
    self.class.post('/create', body: payload)
  end

  def process_response(response)
    case response.code
    when 201
      lead.save
    when 400
      add_validation_errors(response)
      false
    when 401, 500
      add_generic_error
      false
    end
  end

  def payload
    lead_attributes.merge(mic_api_access_fields)
  end

  def lead_attributes
    lead.slice('name', 'business_name', 'email', 'telephone_number')
  end

  def mic_api_access_fields
    {
      pGUID: ENV['LEAD_API_PGUID'],
      pAccName: ENV['LEAD_API_PACCNAME'],
      pPartner: ENV['LEAD_API_PPARTNER'],
      access_token: ENV['LEAD_API_ACCESS_TOKEN']
    }
  end

  def add_validation_errors(response)
    response.parsed_response['errors'].each do |error|
      _full_error, field, message = error.match(/Field '(.*?)' (.*)/).to_a
      lead.errors.add(field, message) if lead_attributes.key?(field)
    end
  end

  def add_generic_error
    lead.errors[:base] << I18n.t('lead_api_errors.internal_error_retry_later')
  end
end
