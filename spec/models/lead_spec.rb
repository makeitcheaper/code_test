require 'rails_helper'

RSpec.describe Lead do

  let!(:lead) do
   Lead.new(name: 'John Smith', business_name: 'Bank', 
   telephone_number: '+44 2222 333 444', email: 'smith@bank.co.uk')
  end

  it 'is valid' do 
    expect(lead).to be_valid
  end

  it 'has right attributes' do
    expect(lead.name).to eq 'John Smith'
    expect(lead.business_name).to eq 'Bank'
    expect(lead.telephone_number).to eq '+44 2222 333 444'
    expect(lead.email).to eq 'smith@bank.co.uk'
  end
end