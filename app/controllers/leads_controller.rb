# frozen_string_literal: true

class LeadsController < ApplicationController
  def new; end

  def create
    @lead = Lead.new(lead_params)
    @lead.save!
  rescue StandardError => e
    @errors = e.try(:response).try(:errors)
    render :new
  end

  def lead_params
    params.require(:lead).permit(
      :name,
      :business_name,
      :telephone_number,
      :email,
      :notes
    )
  end
end
