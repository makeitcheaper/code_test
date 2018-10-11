# frozen_string_literal: true

require 'rails_helper'

describe LeadSubmitter do
  let(:valid_params) do
    {
      name: 'Bob Jones',
      business_name: 'Bob Jones Enterprises',
      telephone_number: '02071234567',
      email: 'bob@bobjones.com',
      contact_time: '2008-01-01 03:00:00',
      notes: '',
      reference: ''
    }
  end
  let(:lead) { Lead.new(lead_params) }
  let(:subject) { described_class.new(lead) }

  context 'validation' do
    context 'with valid parameters' do
      let(:lead_params) { valid_params }
      it_behaves_like 'successful lead creation'
    end

    context 'with a blank name' do
      let(:lead_params) { valid_params.merge(name: '') }
      it_behaves_like 'unsuccessful lead creation', :name
    end

    context 'with a blank business name' do
      let(:lead_params) { valid_params.merge(business_name: '') }
      it_behaves_like 'unsuccessful lead creation', :business_name
    end

    context 'with a blank telephone number' do
      let(:lead_params) { valid_params.merge(telephone_number: '') }
      it_behaves_like 'unsuccessful lead creation', :telephone_number
    end

    context 'with a telephone number that is too short' do
      let(:lead_params) { valid_params.merge(telephone_number: '1234567890') }
      it_behaves_like 'unsuccessful lead creation', :telephone_number
    end

    context 'with a telephone number that is too long' do
      let(:lead_params) { valid_params.merge(telephone_number: '12345678901234') }
      it_behaves_like 'unsuccessful lead creation', :telephone_number
    end

    context 'with a telephone number that contains alpha characters' do
      let(:lead_params) { valid_params.merge(telephone_number: 'ABCD5678901') }
      it_behaves_like 'unsuccessful lead creation', :telephone_number
    end

    context 'with an email address that not an email' do
      let(:lead_params) { valid_params.merge(email: 'NOT_AN_EMAIL') }
      it_behaves_like 'unsuccessful lead creation', :email
    end

    context 'with a contact time in an incorrect format' do
      let(:lead_params) { valid_params.merge(contact_time: 'NOT_A_CONTACT_TIME') }
      it_behaves_like 'unsuccessful lead creation', :contact_time
    end

    context 'with notes that are too long' do
      let(:lead_params) { valid_params.merge(notes: 'A' * 256) }
      it_behaves_like 'unsuccessful lead creation', :notes
    end

    context 'with a reference that is too long' do
      let(:lead_params) { valid_params.merge(reference: 'A' * 51) }
      it_behaves_like 'unsuccessful lead creation', :reference
    end
  end

  context 'server error' do
    before do
      stub_request(:post, LeadSubmitter::ENDPOINT)
        .to_return(
          status: 400,
          body: {
            message: 'Format errors on validation',
            errors: [
              "Field 'telephone_number' wrong format (must contain have valid phone number with 11 numbers. string max 13 chars)"
            ]
          }.to_json
        )
    end

    context 'when our validations pass but a server error occurs' do
      let(:lead_params) { valid_params }
      it 'raises a validation error' do
        expect(subject.submit).to be false
        expect(lead.errors).not_to be_empty
        expect(lead.errors.messages).to have_key :telephone_number
        expect(lead.errors.messages[:telephone_number][0]).to eql 'must contain have valid phone number with 11 numbers. string max 13 chars'
      end
    end
  end
end
