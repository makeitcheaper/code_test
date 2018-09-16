class LeadsController < ApplicationController
  def new
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(lead_params)

    if @lead.valid?
      @api_result = post_to_api

      if @api_result.status == 201
        flash[:message] = 'Successfully sent to the API'
        redirect_to :thankyou_leads
      else
        flash.now[:alert] = 'The API returned an error'
        render :new
      end
    else
      flash.now[:alert] = 'Some of the values you supplied are invalid'
      render :new
    end
  end

  private

  def post_to_api
    Api.enqueue(
      token: ENV['LEAD_API_ACCESS_TOKEN'],
      user_id: ENV['LEAD_API_PGUID'],
      acc_name: ENV['LEAD_API_PACCNAME'],
      partner_name: ENV['LEAD_API_PPARTNER'],
      name: @lead.customer_full_name,
      business_name: @lead.business_name,
      tel_number: @lead.telephone_number,
      email: @lead.email
    )
  end

  def lead_params
    params.require(:lead).permit(:customer_full_name, :business_name, :email, :telephone_number)
  end
end
