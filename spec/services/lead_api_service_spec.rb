require 'rails_helper'

describe LeadApiService do
  before do
    @lead = Lead.new(FactoryBot.build(:lead, :internal).as_json)
    @lead_api_service = LeadApiService.new(@lead)
  end
end
