# frozen_string_literal: true

class LeadForm
  include ActiveModel::Model

  attr_accessor :name, :business_name, :telephone_number, :email, :contact_time,
                :notes, :reference, :lead_repository

  validates :name, presence: true, length: { maximum: 100 }
  validates :business_name, presence: true, length: { maximum: 100 }
  validates :telephone_number, presence: true, length: { maximum: 13 }
  validates :email, presence: true, length: { maximum: 80 }
  validates :notes, length: { maximum: 255 }
  validates :reference, length: { maximum: 50 }

  def initialize(attributes = {})
    super

    @lead_repository = attributes[:lead_repository] || LeadAPI
  end

  def save
    return false unless valid?

    lead = lead_repository.new(lead_attributes).save

    if lead.errors.any?
      add_errors_from_lead(lead)
      false
    else
      true
    end
  end

  private

  def lead_attributes
    {
      name: name,
      business_name: business_name,
      telephone_number: telephone_number,
      email: email,
      contact_time: contact_time,
      notes: notes,
      reference: reference
    }
  end

  def add_errors_from_lead(lead)
    lead.errors.each do |error|
      errors.add(:base, error)
    end
  end
end
