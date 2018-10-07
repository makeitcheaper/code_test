require 'rails_helper'

RSpec.describe Lead, type: :model do
  before { @lead = FactoryBot.build(:lead) }

  subject { @lead }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:business_name) }
  it { should respond_to(:telephone_number) }
  it { should respond_to(:contact_time) }
  it { should respond_to(:notes) }
  it { should respond_to(:reference) }

  it { is_expected.to validate_presence_of(:name).with_message('Name is required') }
  it { is_expected.to validate_presence_of(:email).with_message('Email invalid') }
  it { is_expected.to validate_presence_of(:business_name).with_message('Business name is required') }
  it { is_expected.to validate_presence_of(:telephone_number).with_message('Telephone number is required') }

  it { is_expected.to validate_length_of(:business_name).is_at_most(100).with_message("Business name can contain max 100 chars") }
  it { is_expected.to validate_length_of(:reference).is_at_most(50).with_message("Reference can contain 50 chars") }
  it { is_expected.to validate_length_of(:notes).is_at_most(255).with_message("Notes can contain max 255 chars") }

  it { should be_valid }
end
