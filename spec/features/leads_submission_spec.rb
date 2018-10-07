# frozen_string_literal: true

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
        VCR.use_cassette('mic-api-201') do
          click_button 'Submit'
        end
      end

      it 'displays a thank you message' do
        expect(page).to have_content('Thank you for getting in touch! We will get back to you shortly.')
      end
    end

    context 'when MIC API validation fails' do
      before do
        fill_in 'Customer full name', with: 'Bob'
        VCR.use_cassette('mic-api-400') do
          click_button 'Submit'
        end
      end

      it 'displays errors returned from MIC API' do
        expect(page).to have_content("'name' must be composed with 2 separated words (space between)")
      end
    end

    context 'when MIC API is not available' do
      before do
        VCR.use_cassette('mic-api-401') do
          click_button 'Submit'
        end
      end

      it 'presents the user with a nice message' do
        expect(page).to have_content('Internal app error, try again later.')
      end
    end
  end

  context 'when data is not valid' do
    before do
      click_button 'Submit'
    end

    it 'validates form fields' do
      expect(page).to have_content('Please review the problems below:')
    end
  end
end
