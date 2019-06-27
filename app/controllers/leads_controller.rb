class LeadsController < ApplicationController
  before_action :load_lead

  def new

  end

  def create
    if @lead.save
      render :create, notice: 'lead creation successful'
    else
      render :new
    end
  end

  private

  def lead_params
  end

  def load_lead
    @lead = Lead.new(lead_params)
  end
end
