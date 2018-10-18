require 'rails_helper'


RSpec.describe 'Lead Api' do
  let (:lead_api_uri_re) { Regexp.new URI.parse(LeadApi.base_uri).host }

  it 'submits a lead' do
    stub_request(:any, lead_api_uri_re)

    lead = build(:lead_thomas)
    lead_api = LeadApi.new
    ret = lead_api.post_lead lead.to_h

    assert ret

    # Check all values are present in body of the api request
    assert_requested(:post, "#{LeadApi.base_uri}/create", times: 1) do |req|
      lead.to_h.values.all? { |value| req.body =~ /#{value}/ }
    end
  end


  it 'raises an error on 500' do
    stub_request(:any, lead_api_uri_re)
      .to_return(status: 500)

    lead = build(:lead_thomas)
    lead_api = LeadApi.new

    expect { lead_api.post_lead lead.to_h }.to(
      raise_error(HTTParty::ResponseError)
    )

    # Check all values are present in body of the api request
    assert_requested(:post, "#{LeadApi.base_uri}/create", times: 1) do |req|
      lead.to_h.values.all? { |value| req.body =~ /#{value}/ }
    end
  end
end
