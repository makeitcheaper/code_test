
# TODO: Edge Cases need to be done
#       - Required Info and Extra info results in successful
#       - Errors are correctly displayed when validation fails

describe "submitting a valid lead", type: :feature do
  it "successfuly submits the form if all required info is supplied", :vcr do
    visit '/'

    fill_in 'lead_name', with: 'Bob Dylan'
    fill_in 'lead_business_name', with: 'Dylan Enterprises'
    fill_in 'lead_telephone_number', with: '02071234567'
    fill_in 'lead_email', with: 'bob@dylan.com'

    click_button 'Create'
    expect(page).to have_content 'Success'
  end
end
