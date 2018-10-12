class LeadsController < ApplicationController
  def show
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(permitted_lead_params)

    if LeadSubmitter.submit(@lead)
      # RENDER DEFAULT TEMPLATE
    else
      render :show
    end
  end

  private

  def permitted_lead_params
    lead_params.permit(*Lead::ATTRIBUTES)
  end

  # TODO: Put this somewhere, although not "optimal" the mess here is pretty self contained and
  #       doesnt extend outside of this function. So optimizing this further does not currently
  #       bring much benefit
  def lead_params
    contact_time_keys = params[:lead].keys.grep(/^contact_time/)
    contact_time_values = contact_time_keys.sort.map { |a| params[:lead][a].to_i }

    puts '>>>'
    puts contact_time_keys.inspect
    puts contact_time_values.inspect
    puts '<<<'

    unless contact_time_values.all?(&:zero?)
      contact_time = DateTime.civil(*contact_time_values)
    end

    params.require(:lead).except(*contact_time_keys, :contact_time).merge(contact_time: contact_time)
  end
end
