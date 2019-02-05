# frozen_string_literal: true

require 'rails_helper'

describe Api::Client do
  let(:uri) { 'http://example.com/api' }
  let(:params) do
    {
      param1: 'value1',
      param2: 'value2'
    }
  end
  let(:headers) do
    {
      HEADER_1: 'value1',
      HEADER_2: 'value2'
    }
  end
  let(:parsed_json) do
    {
      result1: 'value1',
      result2: 'value2'
    }.with_indifferent_access
  end

  subject { described_class.new(uri) }

  context '#call' do
    context 'when API call successful' do
      before do
        stub_request(:get, uri)
          .with(
            query: params,
            headers: headers
          )
          .to_return(
            body: MultiJson.dump(parsed_json),
            status: 200
          )
      end

      it 'returns parsed JSON' do
        expect(subject.call(:get, params, headers)).to eq(parsed_json)
      end
    end

    context 'when API call unsuccessful' do
      before do
        stub_request(:get, uri)
          .with(
            query: params,
            headers: headers
          )
          .to_return(
            status: 500
          )
      end

      it 'raises an error' do
        message = 'Unsuccessful API call, uri: http://example.com/api, params: (param1: value1, param2: value2), status: 500'
        expect { subject.call(:get, params, headers) }
          .to raise_error(Api::ClientError, message)
      end
    end

    context 'when received empty string' do
      before do
        stub_request(:get, uri)
          .with(
            query: params,
            headers: headers
          )
          .to_return(
            body: '',
            status: 200
          )
      end

      it 'raises an error' do
        message = 'Unsuccessful API call, uri: http://example.com/api, params: (param1: value1, param2: value2), status: 200'
        expect { subject.call(:get, params, headers) }
          .to raise_error(Api::ClientError, message)
      end
    end

    context 'when received empty object' do
      before do
        stub_request(:get, uri)
          .with(
            query: params,
            headers: headers
          )
          .to_return(
            body: '{}',
            status: 200
          )
      end

      it 'raises an error' do
        message = 'Unsuccessful API call, uri: http://example.com/api, params: (param1: value1, param2: value2), status: 200'
        expect { subject.call(:get, params, headers) }
          .to raise_error(Api::ClientError, message)
      end
    end
  end
end
