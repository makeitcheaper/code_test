# frozen_string_literal: true

require 'rails_helper'

describe Api::ClientError do
  context '#initialize' do
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
      let(:uri) { 'http://example.com' }
      let(:params) { { key: 'value', password: 'secret' } }
      let(:status) { 500 }
      it 'has the correct message ' do
        expect { raise described_class.new('MESSAGE', uri: uri, params: params, status: status) }
          .to raise_error('MESSAGE, uri: http://example.com, params: (key: value), status: 500')
      end
    end
  end
end
