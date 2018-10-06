require 'rails_helper'

RSpec.describe 'Leads submission', type: :feature do
  before do
    visit new_lead_path
  end

  context 'when data is valid' do
    before do
      fill_in 'Customer full name', with: 'Bob Dylan'
      fill_in 'Business name', with: 'Columbia Records'
      fill_in 'Email', with: 'bob@dylan.com'
      fill_in 'Telephone number', with: '07123456789'
    end

    context 'when MIC API is available' do
      before do
        # expect call to API and return success
        click_button 'Submit'
      end

      it 'displays a thank you message' do
        expect(page).to have_content('Thank you for getting in touch! We will get back to you shortly.')
      end
    end

    context 'when MIC API is not available' do
      before do
        # expect call to API and return error
        click_button 'Submit'
      end

      it 'presents the user with a nice message' do
        expect(page).to have_content('The service is not available at the moment. Please try again later.')
      end
    end
  end

  context 'when data is not valid' do
    before do
      click_button 'Submit'
    end

    it 'validates form fields' do
      expect(page).to have_content('There was an error submitting the form.')
    end
  end
end
