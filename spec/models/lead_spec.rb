require 'rails_helper'

RSpec.describe Lead do
  subject do
    Lead.new(customer_full_name: customer_full_name, business_name: business_name, email: email, telephone_number: tel_number)
  end

  let(:customer_full_name) { 'Bob Billis' }
  let(:business_name) { 'Widgets Co' }
  let(:email) { 'bob@widgets.com' }
  let(:tel_number) { '01273-988988' }

  context 'valid' do
    it do
      expect(subject.valid?).to eq true
    end
  end

  context 'invalid customer full name' do
    let(:customer_full_name) { 'Bob-Billis' }

    it do
      expect(subject.valid?).to eq false
      expect(subject.errors.full_messages_for(:customer_full_name)).to eq ['Customer full name must be two separate words']
    end
  end

  context 'invalid telephone number' do
    let(:tel_number) { '123 '}

    it do
      expect(subject.valid?).to eq false
      expect(subject.errors.full_messages_for(:telephone_number)).to eq ['Telephone number must contain 11 digits and be no more than 13 characters long']
    end
  end

  context 'invalid email' do
    let(:email) { 'bob@widgetscom' }

    it do
      expect(subject.valid?).to eq false
      expect(subject.errors.full_messages_for(:email)).to eq ['Email format is invalid']
    end
  end
end
