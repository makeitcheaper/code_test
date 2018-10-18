require 'rails_helper'


RSpec.describe 'Leads New', type: :system  do
  include WebMockHelpers

  let (:lead) { build(:lead_thomas) }

  let (:lead_api_host) { URI.parse(LeadApi.base_uri).host }
  let (:lead_api_uri_re) { Regexp.new lead_api_host }


  it 'displays and submits form fields' do
    visit '/leads/new'

    fill_in 'lead[full_name]', with: lead.full_name
    fill_in 'lead[business_name]', with: lead.business_name
    fill_in 'lead[email]', with: lead.email
    fill_in 'lead[phone_number]', with: lead.phone_number

    stub_request(:any, lead_api_uri_re)
    click_button 'Register'

    # Check all values are present in body of the api request
    assert_requested_with_values :post, /#{LeadApi.base_uri}\/create/,
      lead.to_h.values

    expect(page.current_url).to eq thank_you_leads_url
    expect(page).to have_content("Thank you")
  end


  it 'displays error if service is down' do
    visit '/leads/new'

    fill_in 'lead[full_name]', with: lead.full_name
    fill_in 'lead[business_name]', with: lead.business_name
    fill_in 'lead[email]', with: lead.email
    fill_in 'lead[phone_number]', with: lead.phone_number

    stub_request(:any, lead_api_uri_re).to_return(status: 400)
    click_button 'Register'

    # Check all values are present in body of the api request
    assert_requested_with_values :post, /#{LeadApi.base_uri}\/create/,
      lead.to_h.values

    error_msg = I18n.t 'lead_api_errors.internal_error_retry_later'
    expect(page).to have_content(error_msg)
  end
end
