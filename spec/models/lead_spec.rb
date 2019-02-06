# frozen_string_literal: true

require 'rails_helper'

describe Lead, type: :model do
  let(:name) { Faker::Name.name }
  let(:business_name) { 'Some Business Ltd' }
  let(:telephone_number) { '07486444245' }
  let(:email) { Faker::Internet.email }
  let(:notes) { 'NOTES' }
  let(:params) do
    {
      name: name,
      business_name: business_name,
      telephone_number: telephone_number,
      email: email,
      notes: notes
    }
  end

  subject { described_class.new(params) }

  before do
    allow_any_instance_of(MicLeads::V1::CreateEndpoint).to receive(:post)
  end

  shared_examples '#save! correctly' do
    it 'saves correctly' do
      expect { subject.save! }.not_to raise_error
    end
  end

  shared_examples '#save! raised exception' do
    it 'does not save' do
      expect { subject.save! }.to raise_error(ActiveModel::ValidationError)
    end
  end

  describe '#save!' do
    context 'for correct input' do
      it_behaves_like '#save! correctly'
    end

    context 'for empty name' do
      let(:name) { '' }

      it_behaves_like '#save! raised exception'
    end

    context 'for name too long' do
      let(:name) { 'a' * 101 }

      it_behaves_like '#save! raised exception'
    end

    context 'for empty business name' do
      let(:business_name) { '' }

      it_behaves_like '#save! raised exception'
    end

    context 'for business name too long' do
      let(:business_name) { 'a' * 101 }

      it_behaves_like '#save! raised exception'
    end

    context 'for empty telephone number' do
      let(:telephone_number) { '' }

      it_behaves_like '#save! raised exception'
    end

    context 'for telephone number too long' do
      let(:telephone_number) { '7486' + '4' * 10 }

      it_behaves_like '#save! raised exception'
    end

    context 'for empty email' do
      let(:email) { '' }

      it_behaves_like '#save! raised exception'
    end

    context 'for emaili too long' do
      let(:email) { 'a@' + 'a' * 79 }

      it_behaves_like '#save! raised exception'
    end

    context 'for empty notes' do
      let(:notes) { '' }

      it_behaves_like '#save! correctly'
    end

    context 'for notes too long' do
      let(:notes) { 'a' * 256 }

      it_behaves_like '#save! raised exception'
    end

    context 'for invalid name' do
      let(:name) { 'blorb' }

      it_behaves_like '#save! raised exception'
    end

    context 'for non-uk phone number' do
      let(:telephone_number) { '666666666' }

      it_behaves_like '#save! raised exception'
    end

    context 'for invalid email' do
      let(:email) { 'nonemail' }

      it_behaves_like '#save! raised exception'
    end
  end
end
