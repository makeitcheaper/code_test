# frozen_string_literal: true

class Lead < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_presence_of :name, :business_name, :email, :telephone_number
  validates_length_of :name, :business_name, maximum: 100
  validates_length_of :email, maximum: 80
  validates_length_of :telephone_number, maximum: 13
  validates_format_of :email, with: VALID_EMAIL_REGEX
end
