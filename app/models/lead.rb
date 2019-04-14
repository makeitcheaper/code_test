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
  validate :name_composition
  validate :telephone_composition
 
  private
  def name_composition
    if name !~ /\w+\s\w+/
      errors.add(:name , "must be composed with 2 separated words")
    end
  end

  def telephone_composition
    if telephone_number !~ /^(\D*\d){11}$/
      errors.add(:telephone_number , "must be valid UK phone number")
    end
  end

end
