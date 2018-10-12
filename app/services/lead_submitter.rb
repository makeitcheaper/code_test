# frozen_string_literal: true

require 'uri'

class LeadSubmitter
  class << self
    def submit(lead)
      new(lead).submit
    end
  end

  attr_reader :lead

  ENDPOINT = 'http://mic-leads.dev-test.makeiteasy.com/api/v1/create'

  DEFAULT_OPTIONS = {
    access_token: ENV.fetch('LEAD_API_ACCESS_TOKEN'),
    pGUID: ENV.fetch('LEAD_API_PGUID'),
    pAccName: ENV.fetch('LEAD_API_PACCNAME'),
    pPartner: ENV.fetch('LEAD_API_PPARTNER')
  }.freeze

  DEFAULT_HEADERS = {
    'Content-Type' => 'application/x-www-form-urlencoded'
  }.freeze

  def initialize(lead)
    @lead = lead
  end

  def submit
    return false unless lead.valid?

    unless (200..299).cover?(request.code)
      parse_errors
      return false
    end

    true
  rescue Net::OpenTimeout
    set_timeout_error
    false
  end

  private

  def request
    @request ||= HTTParty.post(
      ENDPOINT,
      body: URI.encode_www_form(request_data),
      headers: DEFAULT_HEADERS,
      format: :json
    )
  end

  def request_data
    DEFAULT_OPTIONS.merge(lead.as_json)
                   .merge(contact_time: lead.contact_time.strftime("%Y-%m-%d %H:%M:%S"))
  end

  def parse_errors
    request.parsed_response['errors'].each do |error_description|
      error_parts = error_description.match(/'(\w*)'.*\((.*)\)/)
      lead.errors.add(error_parts[1], :invalid, message: error_parts[2])
    end
  end

  def set_timeout_error
    lead.errors.add(:base, 'An error occurred while we were processing this request')
  end
end
