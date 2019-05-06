# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer, type: :model do
  subject { described_class.new(attrs) }

  let(:attrs) do
    {
      name: 'John Doe',
      business_name: 'Doe Inc',
      telephone_number: '01234 567 890',
      email: 'john.doe@doeinc.co.uk'
    }
  end

  describe '.new' do
    context 'valid attrs' do
      it { expect(subject).to be_valid }
    end

    context 'invalid when name missing' do
      before { attrs[:name] = '' }

      it { expect(subject).to_not be_valid }
    end

    context 'invalid when business_name missing' do
      before { attrs[:business_name] = '' }

      it { expect(subject).to_not be_valid }
    end

    context 'invalid when telephone_number missing' do
      before { attrs[:telephone_number] = '' }

      it { expect(subject).to_not be_valid }
    end

    context 'invalid when telephone_number invalid' do
      before { attrs[:telephone_number] = '123456789' }

      it { expect(subject).to_not be_valid }
    end

    context 'invalid when email missing' do
      before { attrs[:email] = '' }

      it { expect(subject).to_not be_valid }
    end

    context 'invalid when email invalid' do
      before { attrs[:email] = 'john.doe@doeinc' }

      it { expect(subject).to_not be_valid }
    end
  end
end
