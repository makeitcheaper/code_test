# frozen_string_literal: true

describe LeadForm, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:business_name) }
    it { should validate_presence_of(:telephone_number) }
    it { should validate_presence_of(:email) }
  end
end
