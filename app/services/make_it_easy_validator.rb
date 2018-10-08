class MakeItEasyValidator
  include ActiveModel::Model
  
  validates :name, :business_name, :telephone_number, presence: true
  
  def initialize(form_inputs)
    form_inputs.each do |key, value|
      define_singleton_method(key) do
        value
      end
    end
  end
end