# frozen_string_literal: true

class LeadForm
  include ActiveModel::Model

  attr_accessor :name, :business_name, :telephone_number, :email, :contact_time, :notes, :reference

  validates :name, presence: true, length: { maximum: 100 }
  validates :business_name, presence: true, length: { maximum: 100 }
  validates :telephone_number, presence: true, length: { maximum: 13 }
  validates :email, presence: true, length: { maximum: 80 }
  validates :notes, length: { maximum: 255 }
  validates :reference, length: { maximum: 50 }
end
