class ContactForm
  include ActiveModel::Model

  ATTRIBUTES = %i[
    name
    business_name
    telephone_number
    email
    contact_time
    notes
    reference
  ].freeze

  attr_accessor(*ATTRIBUTES)
  attr_reader :message

  validates :name, :business_name, :telephone_number, :email, presence: true
  validate :swagger_api_validator_and_storage

  def save
    if valid?
      @message = 'Enqueue success'
      true
    else
      @message ||= 'Format errors on validation'
      false
    end
  end

  protected

  def swagger_api_validator_and_storage
    result = SwaggerClient.new.create(as_json)
    if result && result['errors']
      result['errors'].each { |msg| errors[:base] << msg }
      @message = result['message']
    else
      errors[:base] << 'Server is not responding'
      @message = 'Server is not responding'
    end
  end
end
