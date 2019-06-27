class Lead
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :name,
                :business_name,
                :telephone_number,
                :email,
                :contact_time,
                :notes,
                :reference


  def save
    MakeItCheaperService.save_lead(self)
  end
end
