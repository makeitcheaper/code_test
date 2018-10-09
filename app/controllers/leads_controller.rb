class LeadsController < ApplicationController
  rescue_from LeadApiService::InternalServerError, with: :internal_server_error
  rescue_from LeadApiService::UnauthorizedAccessToken, with: :unauthorized_access_token
  rescue_from LeadApiService::BadRequest, with: :bad_request

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

  def internal_server_error
    flash.now[:danger] = 'There was an internal server error'
    render 'new'
  end

  def unauthorized_access_token
    flash.now[:danger] = 'There was an internal problem. we will look into right away '
    render 'new'
  end

  def bad_request
    flash.now[:danger] = 'There was an internal problem. A bad request occured'
    render 'new'
  end
end
