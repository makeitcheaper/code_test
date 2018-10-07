# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lead, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:business_name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:telephone_number) }

  it { is_expected.to validate_length_of(:name).is_at_most(100) }
  it { is_expected.to validate_length_of(:business_name).is_at_most(100) }
  it { is_expected.to validate_length_of(:email).is_at_most(80) }
  it { is_expected.to validate_length_of(:telephone_number).is_at_most(13) }

  it { is_expected.to allow_value('bob@dylan.com').for(:email) }
  it { is_expected.not_to allow_value('invalid_email').for(:email) }
end
