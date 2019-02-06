# frozen_string_literal: true

require 'rails_helper'

describe MicLeads::V1::CreateEndpoint do
  describe '#post' do
    context 'with correct parameters' do
      let(:uri) { 'http://example.com/api/v1/create' }
      let(:name) { 'NAME' }
      let(:business_name) { 'BUSINESS NAME' }
      let(:telephone_number) { 'TELEPHONE NUMBER' }
      let(:email) { 'EMAIL' }
      let(:contact_time) { '2019-02-01 12:11:23' }
      let(:notes) { 'SOME NOTES' }
      let(:reference) { 'REFERENCE' }
      let(:required_params) do
        {
          name: name,
          business_name: business_name,
          telephone_number: telephone_number,
          email: email
        }
      end
      let(:optional_params) do
        {
          contact_time: contact_time,
          notes: notes,
          reference: reference
        }
      end
      let(:params_from_config) do
        {
          access_token: 'test_access_token',
          pGUID: 'test_p_guid',
          pAccName: 'test_p_acc_name',
          pPartner: 'test_p_partner'
        }
      end
      let(:parsed_json) do
        {
          message: 'Enqueue success',
          errors: []
        }
      end

      before do
        stub_request(:post, uri)
          .with(
            query: params.merge(params_from_config)
          )
          .to_return(
            body: MultiJson.dump(parsed_json),
            status: 200
          )
      end

      shared_examples '#post examples' do
        it 'returns parsed JSON' do
          expect(subject.post(**params)).to eq(parsed_json.with_indifferent_access)
        end
      end

      context 'with required params only' do
        let(:params) { required_params }

        it_behaves_like '#post examples'
      end

      context 'with all params' do
        let(:params) { required_params.merge(optional_params) }

        it_behaves_like '#post examples'
      end
    end
  end
end
