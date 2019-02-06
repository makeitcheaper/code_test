# frozen_string_literal: true

require 'rails_helper'

describe Api::Client do
  let(:uri) { 'http://example.com/api' }
  let(:query) do
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

  describe '#call' do
    context 'when API call successful' do
      context 'when receiving' do
        before do
          stub_request(:get, uri)
            .with(
              query: query,
              headers: headers
            )
            .to_return(
              body: MultiJson.dump(parsed_json),
              status: 200
            )
        end

        it 'returns parsed JSON' do
          expect(subject.call(:get, query: query, headers: headers)).to eq(parsed_json)
        end
      end

      context 'when sending' do
        let(:body) do
          {
            param3: 'value1',
            param4: 'value2'
          }
        end

        before do
          stub_request(:post, uri)
            .with(
              query: query,
              body: body,
              headers: headers.merge('Content-Type' => 'application/x-www-form-urlencoded')
            )
            .to_return(
              body: MultiJson.dump(parsed_json),
              status: 200
            )
        end

        it 'returns parsed JSON' do
          expect(subject.call(:post, query: query, body: body, headers: headers)).to eq(parsed_json)
        end
      end
    end

    context 'when API call unsuccessful' do
      before do
        stub_request(:get, uri)
          .with(
            query: query,
            headers: headers
          )
          .to_return(
            status: 500,
            body: MultiJson.dump(parsed_json)
          )
      end

      it 'raises an error' do
        expect { subject.call(:get, query: query, headers: headers) }
          .to raise_error(Api::ClientError, /status: 500/)
      end

      it 'has parsed JSON response inside the error' do
        response = begin
                     subject.call(:get, query: query, headers: headers)
                   rescue Api::ClientError => e
                     e.response
                   end
        expect(response).to eq(parsed_json)
      end
    end

    context 'when received empty string' do
      before do
        stub_request(:get, uri)
          .with(
            query: query,
            headers: headers
          )
          .to_return(
            body: '',
            status: 200
          )
      end

      it 'raises an error' do
        expect { subject.call(:get, query: query, headers: headers) }
          .to raise_error(Api::ClientError, /status: 200/)
      end
    end

    context 'when received empty object' do
      before do
        stub_request(:get, uri)
          .with(
            query: query,
            headers: headers
          )
          .to_return(
            body: '{}',
            status: 200
          )
      end

      it 'raises an error' do
        expect { subject.call(:get, query: query, headers: headers) }
          .to raise_error(Api::ClientError, /status: 200/)
      end
    end
  end
end
