# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Lead do
  let(:name) { 'my name' }
  let(:business_name) { 'my business_name' }
  let(:telephone_number) { 'my telephone_number' }
  let(:email) { 'my email' }
  let(:contact_time) { 'my contact_time' }
  let(:notes) { 'my notes' }
  let(:reference) { 'my reference' }

  let(:lead) {
    described_class.new(
      name: name,
      business_name: business_name,
      telephone_number: telephone_number,
      email: email,
      contact_time: contact_time,
      notes: notes,
      reference: reference
    )
  }

  describe '#as_json' do
    subject { lead.as_json }

    it 'returns a json representation of the object' do
      is_expected.to eq({
        'name' => name,
        'business_name' => business_name,
        'telephone_number' => telephone_number,
        'email' => email,
        'contact_time' => contact_time,
        'notes' => notes,
        'reference' => reference,
      })
    end
  end
end
