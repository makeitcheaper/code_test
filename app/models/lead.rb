# frozen_string_literal: true

class Lead
  include ActiveModel::Validations

  validates :name, presence: true, length: { maximum: 100 }, format: { with: /\A(?:[[:graph:]]+ ){1,}[[:graph:]]+\z/ }
  validates :business_name, presence: true, length: { maximum: 100 }
  validates :telephone_number, presence: true, telephone_number: { country: :gb }, length: { maximum: 13 }
  validates :email, presence: true, email: true, length: { maximum: 80 }
  validates :notes, length: { maximum: 255 }

  def initialize(params)
    @name = params[:name]
    @business_name = params[:business_name]
    @telephone_number = params[:telephone_number]
    @email = params[:email]
    @notes = params[:notes]
  end

  def save!
    validate!
    MicLeads::V1::CreateEndpoint.new.post(
      name: name,
      business_name: business_name,
      telephone_number: telephone_number,
      email: email,
      notes: notes,
      contact_time: Time.zone.now.to_formatted_s(:db)
    )
  end

  private

  attr_reader :name, :business_name, :telephone_number, :email, :notes
end
