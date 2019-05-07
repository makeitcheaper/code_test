# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CallbackService do
  describe 'initialize' do
    let(:service) { described_class.new(customer) }
    let(:customer) { Customer.new(attrs) }

    let(:attrs) do
      {
        name: 'John Doe',
        business_name: 'Doe Inc',
        telephone_number: '01234 567 890',
        email: 'john.doe@doeinc.co.uk'
      }
    end

    it { expect(service.customer).to eq(customer) }
    it { expect(service.error[:message]).to be_nil }
    it { expect(service.error[:code]).to be_nil }
  end

  describe 'call' do
    let(:service) { described_class.new(customer) }
    let(:customer) { Customer.new(attrs) }

    before do
      VCR.use_cassette('callback_service', record: :new_episodes) do
        service.call
      end
    end

    context 'valid attrs' do
      let(:attrs) do
        {
          name: 'John Doe',
          business_name: 'Doe Inc',
          telephone_number: '01234 567 890',
          email: 'john.doe@doeinc.co.uk'
        }
      end

      let(:expected) do
        {
          code: nil,
          message: nil
        }
      end

      it { expect(service.error).to eq(expected) }
    end

    context 'invalid attrs' do
      let(:attrs) do
        {
          name: 'John Doe',
          business_name: 'Doe Inc',
          telephone_number: '01234 567 890',
          email: nil
        }
      end

      let(:expected) do
        {
          code: 400,
          message: ["Field 'email' is blank", "Field 'email' wrong format"]
        }
      end

      it { expect(service.error).to eq(expected) }
    end
  end
end
