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
end
