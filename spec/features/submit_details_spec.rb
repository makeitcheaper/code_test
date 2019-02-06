# frozen_string_literal: true

xfeature 'Submit details', type: :feature do
  scenario 'Submit details' do
    visit '/'
    fill_in 'Your full name', with: 'John Smith'
    fill_in 'Name of your business', with: 'My Business Ltd'
    fill_in 'Email', with: 'example@example.com'
    fill_in 'Phone number', with: '07468444444'
    click_button 'Contact us'
    expect(page).to have_text('You have registered successfully')
  end
end
