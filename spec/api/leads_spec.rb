require 'rails_helper'

describe 'Leads endpoint' do
  describe 'POST /leads' do
    let(:url) { '/api/v1/leads' }
    let(:lead_api_endpoint) { 'http://test_lead_api/api/v1/api/v1/create' }
    let(:params) do
      {}
    end

    context 'when all passed parameters are valid' do
      let(:params) do
        {
          email: 'email@example.com',
          business_name: 'Company Ltd',
          name: 'Jane Smith',
          telephone_number: '07777777777',
          contact_time: '2016-11-27 13:45:30',
          notes: 'some notes',
          reference: 'ref #123456'
        }
      end

      let(:lead_api_response_body) do
        {
          "message": "Enqueue success",
          "errors": []
        }
      end

      before do
        stub_request(:post, lead_api_endpoint).
          to_return(:body => lead_api_response_body.to_json, :status => 201)

        post url, params: params
      end

      it 'responds with status: Enqueued' do
        expect(JSON.parse(response.body)).to eq({status: 'Enqueued'}.stringify_keys)
      end

      it 'responds with 422 status' do
        expect(response.code.to_i).to eq(201)
      end
    end

    context 'when parameters are invalid' do
      let(:expected_validation_response) do
        [
          {"messages" => ["is missing", "is empty"], "params" => ["email"]},
          {"messages" => ["is missing", "is empty"], "params" => ["name"]},
          {"messages" => ["is missing", "is empty"], "params" => ["business_name"]},
          {"messages" => ["is missing", "is empty"], "params" => ["telephone_number"]}
        ]
      end

      before do
        post url, params: params
      end

      it 'responds with an error message' do
        expect(JSON.parse(response.body)).to eq(expected_validation_response)
      end

      it 'responds with 422 status' do
        expect(response.code.to_i).to eq(422)
      end
    end

    context 'when error occurred during request processing' do
      let(:params) do
        {
          email: 'email@example.com',
          business_name: 'Company Ltd',
          name: 'Jane Smith',
          telephone_number: '07777777777'
        }
      end

      before do
        allow(LeadService).to receive(:enqueue).and_raise('error')

        post url, params: params
      end

      it 'responds with 400 error' do
        expect(response.code.to_i).to eq(400)
      end

      it 'responds with error message' do
        expect(JSON.parse(response.body)).to eq({error: 'Unable to enqueue a lead.'}.stringify_keys)
      end
    end
  end
end
