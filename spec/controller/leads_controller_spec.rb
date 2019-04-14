require 'rails_helper'

RSpec.describe LeadsController, :vcr, type: :controller do
  render_views

  context 'form functionality' do  
    it 'renders the form with fields' do 
     get :new
     #expect(response.body).to match '/message\[name\]/'
    end
  end
  
  context 'form functionality' do
    it "post the lead" do
      VCR.use_cassette("lead_post") do
        post :create, params: {
          lead: {
            name: 'John Smith',
            business_name: 'Bank',
            telephone_number: '+442222333444',
            email: 'smith@bank.co.uk'
          }
        }
        requested_url = "#{ENV['LEAD_API_URI']}/api/v1/create"
        expect(WebMock).to have_requested(:post, requested_url)
        expect(response).to redirect_to(new_lead_url)
      end
    end
  end
end