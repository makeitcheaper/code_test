class LeadsController < ApplicationController
  def index
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(lead_params)
    if @lead.valid?
      submission = LeadApiService.new(@lead).call
    else
      render 'index'
    end
  end

  private

  def lead_params
    params.require(:lead).permit(:name, :business_name,
      :email, :telephone_number, :access_token, :pGUID, :pAccName, :pPartner)
  end
end
