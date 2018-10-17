require 'rails_helper'

RSpec.describe LeadsController, type: :request do
  describe '#create' do
    let(:valid_params) {
      {
        'lead' => {
          'name' => 'Adrian Booth',
          'business_name' => 'Booth Consultants',
          'telephone_number' => '07811111111',
          'email' => 'test@testing.com',
          'access_token' => ENV["LEAD_API_TOKEN"],
          'pGUID' => ENV["LEAD_API_PGUID"],
          'pAccName' => ENV["LEAD_API_PACCNAME"],
          'pPartner' => ENV["LEAD_API_PPARTNER"],
        }
      }
    }

    before do
      allow(HTTParty).to receive(:post).and_return(response)
    end

    context 'when the api call is successful' do
      let(:response) { double('Response', :success? => true, code: 301) }

      it 'redirects to a thank you page with a successful message' do
        post "/leads/create",  params: valid_params

        expect(response.code).to eq(301)
      end
    end
    
    context 'when the request is unsuccessful because of invalid inputs' do
      let(:invalid_params) {
        {
          'lead' => {
            'name' => '',
            'business_name' => 'Booth Consultants',
            'telephone_number' => '07811111111',
            'email' => 'test@testing.com',
            'access_token' => ENV["LEAD_API_TOKEN"],
            'pGUID' => ENV["LEAD_API_PGUID"],
            'pAccName' => ENV["LEAD_API_PACCNAME"],
            'pPartner' => ENV["LEAD_API_PPARTNER"],
          }
        }
      }

      it 'redirects to the new page with errors in the session' do
        post "/leads/create",  params: invalid_params
        
        expect(session['errors'].messages.any?).to eq(true)
        expect(response).to redirect_to leads_new_path
      end

      it 'redirects to the new page with form inputs in the params' do
        post "/leads/create",  params: invalid_params

        expect(response).to redirect_to(leads_new_path(
          name: invalid_params[:name],
          business_name: invalid_params[:business_name],
          telephone_number: invalid_params[:telephone_number],
          email: invalid_params[:email]
        ))
      end
    end

    context 'when the request is unsuccessful because of an api failure' do
      let(:response) { double(
                        'Response',
                        :success? => false,
                        code: 500,
                        errors: { make_it_easy: ['API call failed'] })
                      }

      it 'redirects to the new page with a try again message in a session' do
        post "/leads/create",  params: valid_params

        expect(session['errors']).to eq({ make_it_easy: ['API call failed'] })
        expect(response).to redirect_to leads_new_path
      end
    end
  end
end