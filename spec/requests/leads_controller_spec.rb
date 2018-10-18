require 'rails_helper'


RSpec.describe LeadsController, type: :request do
  let (:lead_api_uri_re) { Regexp.new URI.parse(LeadApi.base_uri).host }


  describe 'GET /leads/new' do
    it 'responds with success' do
      get '/leads/new'
      expect(response).to be_successful
    end
  end


  describe 'POST /leads' do
    it 'responds with redirect when success' do
      lead = build :lead_thomas

      stub_request(:any, lead_api_uri_re).to_return(status: 400)
      post '/leads', params: { lead: lead.to_h }

      expect(response).to be_redirect
    end


    it 'responds with success when validations fail' do
      lead = Lead.new

      stub_request(:any, lead_api_uri_re).to_return(status: 400)
      post '/leads', params: { lead: lead.to_h }

      expect(response).to be_successful
    end


    it 'responds with success when lead api error' do
      lead = build :lead_thomas

      stub_request(:any, lead_api_uri_re).to_return(status: 400)

      post '/leads', params: { lead: lead.to_h }

      expect(response).to be_successful
    end
  end
end
