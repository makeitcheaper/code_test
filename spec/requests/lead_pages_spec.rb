require 'rails_helper'

describe "Lead pages" do
  subject { page }

  describe "Contact page" do
    before { visit root_path }

    it { should have_content('About Us') }
    it { should have_title('Make it Cheaper') }
  end

  describe "callback request" do
    before { visit root_path }

    describe "with invalid information" do
      before { click_button "create" }

      it { should have_title('Make it Cheaper') }
      it { should have_content('Invalid') }
    end
  end
end
