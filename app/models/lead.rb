# frozen_string_literal: true

require 'uri'

class Lead
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  ATTRIBUTES = %i[
    name business_name telephone_number email contact_time notes reference
  ].freeze

  attr_accessor(*ATTRIBUTES)

  validates_presence_of :name, :business_name, :telephone_number, :email
  validates_format_of :name, with: /\w* \w*/
  validates_length_of :business_name, maximum: 30
  validates_length_of :telephone_number, is: 11
  validates_numericality_of :telephone_number
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates_presence_of :contact_time
  validates_length_of :notes, maximum: 255
  validates_length_of :reference, maximum: 50

  def initialize(values = {})
    values.each_pair { |k, v| public_send("#{k}=", v) }
  end

  def save
    LeadSubmitter.new(self).submit
  end

  def as_json
    super only: ATTRIBUTES.map(&:to_s)
  end

  def persisted?
    false
  end
end
