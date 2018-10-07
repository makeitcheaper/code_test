# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendLead, type: :service do
  context 'with invalid lead' do
    subject(:service) { described_class.new(invalid_lead) }

    let(:invalid_lead) { Lead.new }

    it 'returns false' do
      expect(service.call).to be false
    end

    it 'does not create a lead' do
      service.call

      expect(invalid_lead).not_to be_persisted
    end

    it 'adds validation errors' do
      service.call

      expect(invalid_lead.errors.messages).to be_many
    end
  end

  context 'with a valid lead' do
    subject(:service) { described_class.new(valid_lead) }

    let(:valid_lead) { build(:lead) }

    context 'when MIC API is available' do
      it 'returns true' do
        VCR.use_cassette('mic-api-201') do
          expect(service.call).to be true
        end
      end

      it 'creates a lead' do
        VCR.use_cassette('mic-api-201') do
          service.call
        end

        expect(valid_lead).to be_persisted
      end
    end

    context 'when MIC API validation fails' do
      let(:valid_lead) { build(:lead, name: 'Bob') }

      it 'returns false' do
        VCR.use_cassette('mic-api-400') do
          expect(service.call).to be false
        end
      end

      it 'does not create a lead' do
        VCR.use_cassette('mic-api-400') do
          service.call
        end

        expect(valid_lead).not_to be_persisted
      end

      it 'adds validation errors' do
        VCR.use_cassette('mic-api-400') do
          service.call
        end

        expect(valid_lead.errors.messages[:name])
          .to eq ["wrong format, 'name' must be composed with 2 separated words (space between)"]
      end
    end

    context 'when MIC API is not available' do
      it 'returns false' do
        VCR.use_cassette('mic-api-401') do
          expect(service.call).to be false
        end
      end

      it 'does not create a lead' do
        VCR.use_cassette('mic-api-401') do
          service.call
        end

        expect(valid_lead).not_to be_persisted
      end

      it 'adds validation errors' do
        VCR.use_cassette('mic-api-401') do
          service.call
        end

        expect(valid_lead.errors.messages[:base])
          .to eq ['Internal app error, try again later.']
      end
    end
  end
end
