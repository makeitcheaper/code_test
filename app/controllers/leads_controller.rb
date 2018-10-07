class LeadsController < ApplicationController

  def index
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(lead_params)
  end

  private

  def lead_params
    params.require(:lead).permit(:name, :business_name,
      :email, :telephone_number)
  end
end
