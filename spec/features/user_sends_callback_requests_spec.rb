require 'rails_helper'

RSpec.feature "User sends a callback requests", type: :feature do
  scenario 'successful callback request' do
    visit '/'
    expect(page).to have_text("Words describing the product or service you're asking about")

    VCR.use_cassette 'successful_request' do
      fill_in 'Customer full name', with: 'Bob Billiards'
      fill_in 'Business name', with: 'Billiards Chocolate Biscuit Co'
      fill_in 'Email', with: 'bob@billiards.com'
      fill_in 'Telephone number', with: '01273677677'
      click_button 'Request callback'
    end

    expect(page).to have_text('Thankyou! Your callback request has been successfully sent. MakeItCheaper will contact you shortly')
  end

  scenario 'invalid form value' do
    visit '/'
    fill_in 'Customer full name', with: 'Bob Billiards'
    fill_in 'Business name', with: 'Billiards Chocolate Biscuit Co'
    fill_in 'Email', with: 'bob@billiards.com'
    fill_in 'Telephone number', with: '666'
    click_button 'Request callback'

    expect(page).to have_text('Some of the values you supplied are invalid')
    expect(page).to have_text('must contain 11 digits and be no more than 13 characters long')
  end

  scenario 'API error' do
    visit '/'

    VCR.use_cassette 'api_error' do
      fill_in 'Customer full name', with: 'Bob Billiards'
      fill_in 'Business name', with: 'Billiards Chocolate Biscuit Co'
      fill_in 'Email', with: 'bob@billiards.com'
      fill_in 'Telephone number', with: '01273-677677'
      click_button 'Request callback'
    end

    expect(page).to have_text('There was a problem sending your callback request')
  end
end
