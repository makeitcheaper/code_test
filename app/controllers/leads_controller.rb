class LeadsController < ApplicationController
  add_flash_types :success

  def new
    @lead = Lead.new
  end

  def create

    lead_params = params.require(:lead).permit(:name, :business_name, :telephone_number, :email)
    @lead = Lead.new lead_params
    if @lead.valid?
        client = Faraday.new(:url => ENV['LEAD_API_URI'])
        lead_body = {
          access_token: ENV['LEAD_API_ACCESS_TOKEN'],
          pGUID: ENV['LEAD_API_PGUID'],
          pAccName: ENV['LEAD_API_PACCNAME'],
          pPartner: ENV['LEAD_API_PPARTNER'],
          name: lead_params[:name],
          business_name: lead_params[:business_name],
          telephone_number: lead_params[:telephone_number],
          email: lead_params[:email]
        }
        response = client.post do |req|
          req.url '/api/v1/create'
          req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
          req.body = URI.encode_www_form(lead_body)
        end
        if response.status == 201
          redirect_to new_lead_url, success: 'Thank you, we will contact you soon!'
        else
          flash.now[:error] = 'We were unable to send your request right now. Please try later.'
          render :new
        end
    else
      render :new
    end
  end
end
