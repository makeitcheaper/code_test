class LeadsController < ApplicationController

  def new
    @form_params = OpenStruct.new(params)
  end

  def create
    CreateLeadService.new.call(params) do |m|
      m.success do |value|
        redirect_to action: :success
      end
    
      m.failure do |errors|
        session[:errors] = errors
        redirect_to leads_new_path(
          name: params[:name],
          business_name: params[:business_name],
          telephone_number: params[:telephone_number],
          email: params[:email]
        )
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