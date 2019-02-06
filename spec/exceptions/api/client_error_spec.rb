# frozen_string_literal: true

require 'rails_helper'

describe Api::ClientError do
  describe '#initialize' do
    context 'when raised without message' do
      it 'has the correct message' do
        expect { raise described_class }.to raise_error('Unsuccessful API call')
      end
    end

    context 'when raised with message' do
      it 'has the correct message' do
        expect { raise described_class, 'MESSAGE' }.to raise_error('MESSAGE')
      end
    end

    context 'when raised with all parameters' do
      let(:method) { :get }
      let(:uri) { 'http://example.com' }
      let(:query) { { key1: 'value', password: 'secret' } }
      let(:body) { { key2: 'value', password: 'secret' } }
      let(:status) { 500 }

      it 'has the correct message ' do
        expect { raise described_class.new('MESSAGE', method: method, uri: uri, query: query, body: body, status: status) }
          .to raise_error('MESSAGE, method: get, uri: http://example.com, query: (key1: value), body: (key2: value), status: 500')
      end
    end
  end

  describe '#response?' do
    context 'when created without response' do
      it 'returns false' do
        expect(subject.response?).to be false
      end
    end

    context 'when created with response' do
      let(:response) { { key: 'value' } }

      subject { described_class.new(response: response) }

      it 'returns true' do
        expect(subject.response?).to be true
      end
    end
  end
end
