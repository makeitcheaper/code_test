# frozen_string_literal: true

require 'rails_helper'

describe 'requesting a callback', type: :feature do
  let(:attributes) do
    {
      email: 'user@example.com',
      business_name: 'Acme Inc',
      telephone_number: '07876666666',
      name: 'Joe Smith'
    }
  end

  scenario 'when submitting a valid callback request' do
    stub_request(:post, /.*/).to_return(
      body: { "message": 'Enqueue success', "errors": [] }.to_json,
      status: 201
    )

    visit '/callback_requests/new'

    within('.new_callback_request') do
      fill_in 'Email', with: attributes[:email]
      fill_in 'Business name', with: attributes[:business_name]
      fill_in 'Telephone number', with: attributes[:telephone_number]
      fill_in 'Name', with: attributes[:name]
    end

    click_button 'Send'

    expect(page).to have_content "Callback Request successfully submitted"
  end

  scenario 'when submitting a invalid callback request' do
    stub_request(:post, /.*/).to_return(
      body: {
        "message": 'Format errors on validation',
        "errors": [
          "Field 'email' wrong format",
          "Field 'business_name' isn't present"
        ]
      }.to_json,
      status: 400
    )

    visit '/callback_requests/new'

    within('.new_callback_request') do
      fill_in 'Email', with: attributes[:email]
      fill_in 'Business name', with: attributes[:business_name]
      fill_in 'Telephone number', with: attributes[:telephone_number]
      fill_in 'Name', with: attributes[:name]
    end

    click_button 'Send'

    expect(page).to have_content "isn't present"
    expect(page).to have_content "wrong format"
  end
end
