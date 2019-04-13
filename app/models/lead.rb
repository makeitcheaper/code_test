class Lead
  include ActiveModel::Model
  attr_accessor :name, :business_name, :telephone_number, :email
  validates :name, presence: true
  validates :name, length: { maximum: 100 }
  validates :business_name, presence: true
  validates :business_name, length: { maximum: 100 }
  validates :telephone_number, presence: true
  validates :telephone_number, length: { maximum: 13 }
  validates :email, presence: true
  validates :email, length: { maximum: 80 }
end
