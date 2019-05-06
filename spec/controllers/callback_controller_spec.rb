# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CallbackController, type: :controller do
  render_views

  describe 'GET #index' do
    subject(:call_endpoint) { get :index }

    before { call_endpoint }

    it { expect(response).to render_template('index') }
  end

  describe 'POST #create' do
    subject(:call_endpoint) { post :create, params: params }

    before do
      VCR.use_cassette('callback_controller', record: :new_episodes) do
        call_endpoint
      end
    end

    context 'valid params' do
      let(:params) do
        {
          customer: {
            name: 'John Doe',
            business_name: 'Doe Inc',
            telephone_number: '01234 567 890',
            email: 'john.doe@doeinc.co.uk'
          }
        }
      end

      it { expect(response).to render_template('create') }
    end
  end
end
