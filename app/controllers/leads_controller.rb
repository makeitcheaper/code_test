class LeadsController < ApplicationController
  def new
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(lead_params)
    if @lead.valid?
      LeadApiService.new(@lead).call
      flash[:success] = 'Thanks'
    else
      flash.now[:danger] = 'Invalid'
    end
    render 'new'
  end

  private

  def lead_params
    params.require(:lead).permit(:name, :business_name,
                                 :email, :telephone_number, :contact_time, :reference,
                                 :notes, :access_token, :pGUID, :pAccName, :pPartner)
  end
end
