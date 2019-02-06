# frozen_string_literal: true

require 'rails_helper'

describe MicLeads::V1::BaseEndpoint do
  describe '#construct_uri' do
    shared_examples '#construct_uri examples' do
      it 'returns correct URI' do
        expect(subject.send(:construct_uri, domain, path)).to eq(uri)
      end
    end

    context 'when domain without final /' do
      let(:domain) { 'http://example.com/abc' }

      context 'when relative path' do
        let(:path) { 'relative/path' }
        let(:uri) { URI('http://example.com/abc/relative/path') }

        it_behaves_like '#construct_uri examples'
      end

      context 'when absolute path' do
        let(:path) { '/absolute/path' }
        let(:uri) { URI('http://example.com/absolute/path') }

        it_behaves_like '#construct_uri examples'
      end
    end

    context 'when domain with final /' do
      let(:domain) { 'http://example.com/abc/' }

      context 'when relative path' do
        let(:path) { 'relative/path' }
        let(:uri) { URI('http://example.com/abc/relative/path') }

        it_behaves_like '#construct_uri examples'
      end

      context 'when absolute path' do
        let(:path) { '/absolute/path' }
        let(:uri) { URI('http://example.com/absolute/path') }

        it_behaves_like '#construct_uri examples'
      end
    end
  end
end
