require 'rails_helper'

RSpec.describe LeadsController, :vcr, type: :controller do
  render_views

  context 'form functionality' do 

    it 'renders the form with fields' do 
     get :new
     expect(response).to render_template("new")
    end

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

    it "lead post failure" do
      VCR.use_cassette("lead_post_error_400") do
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
        expect(response).to render_template("new")
        expect(flash.now[:error]).to be_present
      end
    end

    it "lead post failure" do
      VCR.use_cassette("lead_post_error_401") do
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
        expect(response).to render_template("new")
        expect(flash.now[:error]).to be_present
      end
    end


  end
end