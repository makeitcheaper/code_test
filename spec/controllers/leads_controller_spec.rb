# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LeadsController, type: :controller do
  describe 'GET new' do
    it 'renders the new template' do
      get :new

      assert_template 'leads/new'
    end
  end

  describe 'POST create' do
    context 'with a valid lead' do
      it 'redirects to new lead' do
        allow(SendLead).to receive(:call).and_return(true)

        post :create, params: { lead: { name: 'Bob Dyland' } }

        assert_redirected_to new_lead_path
      end
    end

    context 'with an invalid lead' do
      it 'renders the new template' do
        allow(SendLead).to receive(:call).and_return(false)

        post :create, params: { lead: { name: 'Bob Dyland' } }

        assert_template 'leads/new'
      end
    end
  end
end
