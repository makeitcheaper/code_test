require 'rails_helper'

RSpec.describe LeadsController, type: :request do
  describe '#create' do
    let(:valid_params) {
      {
        'name' => 'Adrian Booth',
        'business_name' => 'Sir Adrian Booth',
        'telephone_number' => '07811111111',
        'email' => 'test@testing.com',
        'access_token' => ENV["LEAD_API_TOKEN"],
        'pGUID' => ENV["LEAD_API_PGUID"],
        'pAccName' => ENV["LEAD_API_PACCNAME"],
        'pPartner' => ENV["LEAD_API_PPARTNER"],
      }
    }

    before do
      allow(HTTParty).to receive(:post).and_return(response)
    end

    context 'when the api call is successful' do
      let(:response) { double('Response', :success? => true, status: 301) }

      it 'redirects to a thank you page with a successful message' do
        post "/leads/create",  params: valid_params
        
        expect(session['success']).to eq('Lead successfully created')
        expect(response.status).to eq(301)
      end
    end
    
    context 'when the request is unsuccessful because of invalid inputs' do
      let(:invalid_params) {
        {
          'name' => '',
          'business_name' => 'Sir Adrian Booth',
          'telephone_number' => '07811111111',
          'email' => 'test@testing.com',
          'access_token' => ENV["LEAD_API_TOKEN"],
          'pGUID' => ENV["LEAD_API_PGUID"],
          'pAccName' => ENV["LEAD_API_PACCNAME"],
          'pPartner' => ENV["LEAD_API_PPARTNER"],  
        }
      }

      it 'redirects to an error page with errors in the session' do
        post "/leads/create",  params: invalid_params
        
        expect(session['errors'].messages.any?).to eq(true)
        expect(response).to redirect_to leads_new_path
      end

      it 'redirects to an error page with form inputs in the session' do
        post "/leads/create",  params: invalid_params
        form_params_session = session['form_params'].permit!.to_h

        expect(form_params_session).to include(invalid_params)
      end
    end

    context 'when the request is unsuccessful because of an api failure' do
      let(:response) { double(
                        'Response',
                        :success? => false,
                        status: 500,
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