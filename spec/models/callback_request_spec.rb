# frozen_string_literal: true

require 'rails_helper'

describe CallbackRequest do
  describe '#save' do
    it 'returns true if the LeadService response is ok' do
      response = double(ok?: true)
      allow(LeadService).to receive(:create).and_return(response)

      expect(subject.save).to eq(true)
    end

    it 'adds errors to the model and returns false if the LeadService returns errors' do
      response = double(ok?: false, validation_errors: { email: ['wrong format'], business_name: ["isn't present"] })

      allow(LeadService).to receive(:create).and_return(response)

      expect(subject.save).to eq(false)
      expect(subject.errors.messages).to eq(business_name: ["isn't present"], email: ['wrong format'])
    end

    it 'returns false if there are no validation errors but the response is still not ok' do
      response = double(ok?: false, validation_errors: [])
      allow(LeadService).to receive(:create).and_return(response)

      expect(subject.save).to eq(false)
    end
  end
end
