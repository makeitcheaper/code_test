require 'rails_helper'

RSpec.describe LeadsController, type: :controller do
  describe "POST #create" do
    let(:lead_params) {{ FactoryBot.build(:lead).instance_values.symbolize_keys }}

    before do
      post :create, params: { lead: lead_params }
    end

    it "should respond with created" do
      expect(response.status).to eq(201)
    end
  end
end
