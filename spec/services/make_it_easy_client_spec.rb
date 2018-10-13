require 'spec_helper'
require_relative '../../app/services/make_it_easy_client'

RSpec.describe MakeItEasyClient do
  let(:make_it_easy_client) {
    MakeItEasyClient.new
  }

  describe '#create_lead' do
    let(:http_client) { HTTParty }

    let(:form_params) {
      {
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

    context 'when an error is encountered' do
      before do
        allow(http_client).to receive(:post).and_raise(error)
      end

      let(:error) { HTTParty::Error }

      it 'returns an OpenStruct that responds to success? and contains errors' do
        expect(make_it_easy_client.create_lead(form_params)).to eq(
          OpenStruct.new(success?: false, errors: {make_it_easy: ["API call failed"]})
        )
      end
    end

    it 'makes a http call to makeiteasy create endpoint' do
      expect(http_client).to receive(:post).with(
        "http://mic-leads.dev-test.makeiteasy.com/api/v1/create",
        body: form_params,
        timeout: 3
      )

      make_it_easy_client.create_lead(form_params)
    end
  end
end