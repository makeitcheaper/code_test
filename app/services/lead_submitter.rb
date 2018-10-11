# frozen_string_literal: true

require 'uri'

class LeadSubmitter
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

    request.parsed_response
  end

  private

  def request
    @request ||= HTTParty.post(
      ENDPOINT,
      body: URI.encode_www_form(DEFAULT_OPTIONS.merge(lead.as_json)),
      headers: DEFAULT_HEADERS,
      format: :json
    )
  end

  def parse_errors
    request.parsed_response['errors'].each do |error_description|
      error_parts = error_description.match(/'(\w*)'.*\((.*)\)/)
      lead.errors.add(error_parts[1], :invalid, message: error_parts[2])
    end
  end
end
