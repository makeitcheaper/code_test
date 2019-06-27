class Lead
  include ActiveModel::Model

  attr_accessor :name,
                :business_name,
                :telephone_number,
                :email,
                :contact_time,
                :notes,
                :reference
end
