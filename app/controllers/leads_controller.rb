class LeadsController < ApplicationController

  def new
    @form_params = OpenStruct.new(session[:form_params])
  end

  def create
    CreateLeadService.new.call(params) do |m|
      m.success do |value|
        session[:success] = 'Lead successfully created'
        redirect_to action: :success
      end
    
      m.failure :validate do |errors|
        session[:errors] = errors
        session[:form_params] = params
        redirect_to leads_new_path
      end
    end 
  end
  
  def success
  end
  
  private
  
  def lead_params
     params.require(:lead).permit!(
       :name, 
       :business_name, 
       :telephone_number, 
       :email, 
       :access_token, 
       :pGUID, 
       :pAccName, 
       :pPartner
     )
  end
end