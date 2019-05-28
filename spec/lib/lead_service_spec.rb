# frozen_string_literal: true

require 'spec_helper'

require_relative '../../lib/lead_service'

describe LeadService do
  describe '#create' do
    it 'sends a request to the lead service to create a new lead with the provided attributes' do
      attributes = { foo: 'bar' }

      stub = stub_request(:post, 'http://mic-leads.dev-test.example.com/api/v1/create').with(
        query: {
          access_token: 'lead_api_token_secret',
          pGUID: 'abc-123',
          pAccName: 'paccname_test',
          pPartner: 'ppartner_test'
        }.merge(attributes)
      )

      described_class.create(attributes)

      expect(stub).to have_been_requested.once
    end

    it 'returns a response object with the status and body of the response' do
      stub_request(:post, /.+/)
        .to_return(
          body: { "message": 'Enqueue success', "errors": [] }.to_json,
          status: 201
        )

      expect(described_class.create({})).to have_attributes(
        status: "201",
        body: { "message": 'Enqueue success', "errors": [] }
      )
    end

    it 'it populates the validation errors hash when we get validation errors back from the API' do
      stub_request(:post, /.+/)
        .to_return(
          body: {
            "message": 'Format errors on validation',
            "errors": [
              "Field 'email' wrong format",
              "Field 'business_name' isn't present"
            ]
          }.to_json,
          status: 400
        )

      response = described_class.create({})

      expect(response.validation_errors).to eq(
        email: ['wrong format'], business_name: ["isn't present"]
      )
    end

    it 'the validation errors defaults to be empty if there are no errors' do
      stub_request(:post, /.+/)
        .to_return(
          body: {
            "message": 'Format errors on validation',
            "errors": []
          }.to_json,
          status: 400
        )

      response = described_class.create({})

      expect(response.validation_errors).to eq({})
    end

    it 'it does not populate the validation errors when the status is not 400' do
      stub_request(:post, /.+/)
        .to_return(
          body: {
            "message": 'Format errors on validation',
            "errors": [
              "Field 'email' wrong format",
              "Field 'business_name' isn't present"
            ]
          }.to_json,
          status: 401
        )

      response = described_class.create({})

      expect(response.validation_errors).to eq({})
    end
  end
end
