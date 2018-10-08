require 'rails_helper'

describe "Lead pages" do
  subject { page }

  describe "contact page" do
    before { visit root_path }

    it { should have_content('About Us') }
    it { should have_title('Make it Cheaper') }
  end

  describe "callback request" do
    before { visit root_path }

    describe "with invalid information" do
      VCR.use_cassette('incorrect_result') do
        before { click_button "create" }

        it { should have_title('Make it Cheaper') }
        it { should have_content('Invalid') }
      end
    end

    describe "with valid information" do
      let(:lead) { FactoryBot.build(:lead) }

      before do
        fill_in "Name",    with: lead.name
        fill_in "Email",   with: lead.email
        fill_in "Business name",    with: lead.business_name
        fill_in "Telephone number", with: lead.telephone_number

        VCR.use_cassette 'requests/valid_information' do
          click_button "create"

          it { should have_content('Thanks') }
        end
      end

    end
  end
end
