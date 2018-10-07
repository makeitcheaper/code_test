class Lead
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :id, :name, :business_name, :email, :telephone_number

  validates :name, presence: { message: I18n.t('lead_api_errors.name_is_required') }
  validates :email, presence: { message: I18n.t('lead_api_errors.email_wrong_format') }
  validates :business_name, presence: { message: I18n.t('lead_api_errors.business_is_required') }
  validates :telephone_number, presence: { message: I18n.t('lead_api_errors.phone_number_required') }
end
