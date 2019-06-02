# frozen_string_literal: true

class LeadsController < ApplicationController
  def new
    lead_form = LeadForm.new

    render :new, locals: { object: lead_form }
  end

  def create
    lead_form = LeadForm.new(lead_form_params)

    if lead_form.save
      redirect_to new_lead_path, notice: 'Thank you, The Company will contact you shortly.'
    else
      flash.now[:alert] = 'An error occured.'
      render :new, locals: { object: lead_form }
    end
  end

  private

  def lead_form_params
    params.require(:lead_form)
          .permit(
            :name,
            :business_name,
            :telephone_number,
            :email,
            :contact_time,
            :notes,
            :reference
          )
  end
end
