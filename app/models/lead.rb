class Lead 
  include ActiveModel::Model


  def self.attributes
    [:full_name, :business_name, :email, :phone_number]
  end

  attr_accessor *self.attributes


  validates :full_name, length: { maximum: 100 }, presence: true,
    format: { with: /\A\w+\s\w+\z/ }
  validates :business_name, length: { maximum: 100 }, presence: true
  validates :email, email: true
  validates :phone_number, length: { maximum: 13 }, presence: true, phone: true


  def to_h
    self.class.attributes.inject({}) do |hash, key|
      hash.merge({ key => self.send(key) })
    end
  end


  def submit
    api = LeadApi.new
    api.post_lead to_h
  end
end
