require 'rails_helper'


RSpec.describe LeadsController, type: :request do
  describe 'GET /leads/new' do
    it 'responds with success' do
      get '/leads/new'
      expect(response).to be_successful
    end
  end


  describe 'POST /leads' do
    it 'responds with success' do
      post '/leads'
      expect(response).to be_successful
    end
  end
end
