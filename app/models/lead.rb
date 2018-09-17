class Lead
  include ActiveModel::Model

  attr_accessor :customer_full_name, :business_name, :email, :telephone_number

  validates :customer_full_name, :business_name, :email, :telephone_number, presence: true
  validates :telephone_number, with: :validate_telephone_number
  validates_format_of :customer_full_name, with: /\A.+\s.+\z/, message: 'must be two separate words'
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: 'format is invalid'

  private

  def validate_telephone_number
    unless telephone_number.scan(/\d/).length == 11 && telephone_number.length <= 13
      self.errors.add(:telephone_number, :invalid_format, message: 'must contain 11 digits and be no more than 13 characters long')
    end
  end
end
