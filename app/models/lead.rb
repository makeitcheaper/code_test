class Lead 
  include ActiveModel::Model


  def self.attributes
    [:full_name, :business_name, :email, :phone_number]
  end

  attr_accessor *self.attributes


  validates_presence_of :full_name, :business_name, :email, :phone_number
  validates :email, email: true
  validates :phone_number, phone: true
end
