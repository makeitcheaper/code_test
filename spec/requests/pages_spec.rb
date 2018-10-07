require 'rails_helper'

describe 'Request callback page' do
  subject { page }

  before { visit root_path }

  it { should have_content('About Us') }
  it { should have_title('Make it Cheaper | Request a callback') }

  describe 'Enquiry Form' do
    context 'when successful' do
      before do
        fill_in "name",              with: "Example User"
        fill_in "business_name",     with: "Ecample ltd"
        fill_in "email",             with: "example@example.com"
        fill_in "telephone_number",  with: "0122332323"

        click_button 'Submit'
      end

      it { should have_selector('.message', text: 'Thanks') }
    end
  end
end
