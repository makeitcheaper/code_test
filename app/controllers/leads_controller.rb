class LeadsController < ApplicationController
  def new
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(lead_params)
    if @lead.valid?
      response = LeadApiService.new(@lead).call
      flash[:success] = 'Thanks'
      render 'new'
    else
      flash.now[:danger] = 'Invalid'
      render 'new'
    end
  end

  private

  def lead_params
    params.require(:lead).permit(:name, :business_name,
      :email, :telephone_number, :contact_time, :reference,
      :notes, :access_token, :pGUID, :pAccName, :pPartner)
  end
end
