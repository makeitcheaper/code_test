module LeadService
  class << self
    def enqueue(attrs)
      LeadApi::Leads.new.create(attrs)
    end
  end
end
