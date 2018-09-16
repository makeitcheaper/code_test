class Lead
  include ActiveModel::Model

  attr_accessor :customer_full_name, :business_name, :email, :telephone_number
  
  validates :customer_full_name, :business_name, :email, :telephone_number, presence: true

  def attributes
    {
      customer_full_name: customer_full_name,
      business_name: business_name,
      email: email,
      telephone_number: telephone_number
    }
  end
end
