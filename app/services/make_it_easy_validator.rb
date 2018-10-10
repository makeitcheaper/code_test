require 'active_model'

class MakeItEasyValidator
  include ActiveModel::Model
  
  validates :name, :business_name, :telephone_number, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'invalid format' }
  
  attr_reader :form_inputs

  def initialize(form_inputs)
    form_inputs.each do |key, value|
      define_singleton_method(key) do
        value
      end
    end
  end
end