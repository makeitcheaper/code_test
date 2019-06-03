# frozen_string_literal: true

describe LeadAPI do
  describe '#save' do
    subject { described_class.new({}).save }

    before do
      stub_request(:any, /#{Rails.configuration.lead_api_base_uri}/).to_return(
        body: {
          message: expected_message,
          errors: expected_errors
        }.to_json,
        status: expected_status
      )
    end

    context 'external API returns 201 created' do
      let(:expected_message) { 'Enqueue success' }
      let(:expected_errors) { [] }
      let(:expected_status) { 201 }

      it 'returns an object with empty errors field' do
        result = subject

        expect(result.errors).to be_empty
      end
    end

    context 'external API returns 400 bad request' do
      let(:expected_message) { 'Format errors on validation' }
      let(:expected_errors) { ['Field \'name\' isn\'t present'] }
      let(:expected_status) { 400 }

      it 'returns an object with errors from API response' do
        result = subject

        expect(result.errors).to eq(expected_errors)
      end
    end

    context 'external API returns 401 unauthorized' do
      let(:expected_message) { 'Unauthorised access_token' }
      let(:expected_errors) { nil }
      let(:expected_status) { 401 }

      it 'returns an object with errors from API response' do
        result = subject

        expect(result.errors).to eq([expected_message])
      end
    end

    context 'external API returns 500 internal server error' do
      let(:expected_message) { 'Can\'t contact Queue Server. Try again later' }
      let(:expected_errors) { ['Can\'t contact Queue Server. Try again later'] }
      let(:expected_status) { 500 }

      it 'returns an object with errors from API response' do
        result = subject

        expect(result.errors).to eq(expected_errors)
      end
    end
  end
end
