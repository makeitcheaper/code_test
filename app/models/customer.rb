# frozen_string_literal: true

require 'securerandom'

class Customer
  include ActiveModel::Model

  attr_accessor :uid, :name, :business_name, :telephone_number, :email, :notes, :reference

  validates :uid, :name, :business_name, :telephone_number, :email, presence: true
  validates :name, :business_name, length: { maximum: 100 }
  validates :telephone_number, length: { maximum: 13 }, format: { with: VALID_PHONE_NUMBERS, multiline: true }
  validates :email, length: { maximum: 80 }, format: { with: VALID_EMAILS }
  validates :notes, length: { maximum: 255 }
  validates :reference, length: { maximum: 50 }

  def initialize(attributes = {})
    super
    @uid ||= SecureRandom.uuid
  end
end
