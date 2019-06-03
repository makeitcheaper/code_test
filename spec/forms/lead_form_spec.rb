# frozen_string_literal: true

describe LeadForm, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(100) }

    it { should validate_presence_of(:business_name) }
    it { should validate_length_of(:business_name).is_at_most(100) }

    it { should validate_presence_of(:telephone_number) }
    it { should validate_length_of(:telephone_number).is_at_most(13) }

    it { should validate_presence_of(:email) }
    it { should validate_length_of(:email).is_at_most(80) }

    it { should validate_length_of(:notes).is_at_most(255) }
    it { should validate_length_of(:reference).is_at_most(50) }
  end

  describe '#save' do
    subject { described_class.new(attributes).save }

    context 'valid form object' do
      let(:attributes) do
        {
          name: 'Name',
          business_name: 'Business name',
          telephone_number: '123',
          email: 'email@example.com',
          lead_repository: lead_repository_class
        }
      end
      let(:lead_repository_class) { double(new: lead_repository) }
      let(:lead_repository) { double(save: lead) }

      context 'lead repository returns no errors on save' do
        let(:lead) { double(errors: []) }

        it 'returns true' do
          expect(subject).to be true
        end
      end

      context 'lead repository returns errors on save' do
        let(:lead) { double(errors: ['Some error']) }

        it 'returns false' do
          expect(subject).to be false
        end
      end
    end

    context 'invalid form object' do
      let(:attributes) { {} }

      it 'returns false' do
        expect(subject).to be false
      end
    end
  end
end
