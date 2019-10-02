require 'rails_helper'

describe 'Lead Api: leads endpoint' do
  let(:endpoint_url) { 'http://test_lead_api/api/v1/api/v1/create' }

  describe '#create' do
    context 'appends parameters derived from api configuration' do
      let(:subject) { LeadApi::Leads }
      let(:endpoint) { subject.new }

      before do
        allow(subject).to receive(:post).and_return(OpenStruct.new({:code => 201, :body => '{}'}))
      end

      it 'calls httpparty :post method with injected configuration' do
        subject.new.create({name: 'name'})

        expect(subject)
          .to have_received(:post).with('/create', {
            multipart: true,
            body: {
              access_token: "test_access_token",
              name: "name",
              pAccName: "test_paccname",
              pGUID: "c5b88f56-00e8-11e8-ba89-0ed5f89f718b",
              pPartner: "test_ppartner"
            }
          })
      end
    end

    context 'when access token is invalid' do
      let(:response_body) do
        {
          "message": "Unauthorised access_token",
          "errors": [
            "Unauthorised access_token"
          ]
        }
      end

      before do
        stub_request(:post, endpoint_url).
          to_return(:body => response_body.to_json, :status => 401)
      end

      it 'returns authorization error' do
        expect {
          LeadApi::Leads.new.create
        }.to raise_error(LeadApi::Error::Authorization)
      end
    end

    context 'with missing parameters' do
      let(:response_body) do
        {
          "message": "Format errors on validation",
          "errors": [
            "Field 'pGUID' isn't present",
            "Field 'pGUID' is blank",
            "Field 'pGUID' wrong format",
            "Field 'pAccName' isn't present",
            "Field 'pAccName' is blank",
            "Field 'pPartner' isn't present",
            "Field 'pPartner' is blank",
            "Field 'name' isn't present",
            "Field 'name' is blank",
            "Field 'name' wrong format, 'name' must be composed with 2 separated words (space between)",
            "Field 'business_name' isn't present",
            "Field 'business_name' is blank",
            "Field 'business_name' wrong format: 100 chars max",
            "Field 'telephone_number' isn't present",
            "Field 'telephone_number' is blank",
            "Field 'telephone_number' wrong format (must contain have valid phone number with 11 numbers. string max 13 chars)",
            "Field 'email' isn't present",
            "Field 'email' is blank",
            "Field 'email' wrong format",
            "Field 'contact_time' wrong format, must be: '2999-12-31 23:59:59' or '2999-12-31 23:59'",
            "Field 'notes' wrong format: 255 chars max",
            "Field 'reference' wrong format: 50 chars max"
          ]
        }
      end

      before do
        stub_request(:post, endpoint_url).
          to_return(:body => response_body.to_json, :status => 400)
      end

      it 'returns validation error' do
        expect { LeadApi::Leads.new.create }.to raise_error { |error|
          expect(error).to be_a(LeadApi::Error::Validation)
          expect(error.errors).to eq(response_body[:errors])
        }
      end
    end

    context 'with valid parameters' do
      let(:response_body) do
        {
          "message": "Enqueue success",
          "errors": []
        }
      end

      before do
        stub_request(:post, endpoint_url).
          to_return(:body => response_body.to_json, :status => 201)
      end

      it 'response with a message' do
        expect(LeadApi::Leads.new.create).to eq(response_body.stringify_keys)
      end
    end
  end
end
