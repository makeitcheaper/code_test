# frozen_string_literal: true

class LeadsController < ApplicationController
  def new
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(lead_params)

    if SendLead.call(@lead)
      redirect_to new_lead_path, notice: I18n.t('success.post_form_created')
    else
      render :new
    end
  end

  private

  def lead_params
    params.require(:lead).permit(:name, :business_name, :email, :telephone_number)
  end
end
