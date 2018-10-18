class LeadsController < ApplicationController
  def create
    @lead = Lead.new lead_params

    if @lead.valid? && @lead.submit
      redirect_to action: :thank_you
    else
      render action: :new, lead: lead_params
    end
  rescue HTTParty::ResponseError => e
    flash.now[:danger] = I18n.t('lead_api_errors.internal_error_retry_later')
    Rails.logger.error(e.full_message)
    render action: :new, lead: lead_params
  end


  def new
    @lead = Lead.new(lead_params)
  end


  def thank_you
  end


  private


  def lead_params
    if params[:lead]
      params[:lead].permit(:full_name, :business_name, :email, :phone_number)
    end
  end
end
