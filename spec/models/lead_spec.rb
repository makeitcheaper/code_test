require 'rails_helper'

RSpec.describe Lead do

  let!(:lead) do
   Lead.new(name: 'John Smith', business_name: 'Bank', 
   telephone_number: '+442222333444', email: 'smith@bank.co.uk')
  end

  it 'is valid' do 
    expect(lead).to be_valid
  end

  it 'has right attributes' do
    expect(lead.name).to eq 'John Smith'
    expect(lead.business_name).to eq 'Bank'
    expect(lead.telephone_number).to eq '+442222333444'
    expect(lead.email).to eq 'smith@bank.co.uk'
  end

  it 'requires name' do
    lead.name = nil
    expect(lead).to_not be_valid
  end

  it 'requires name to have max 100 chars' do
    lead.name = 'J' * 101 
    expect(lead).to_not be_valid
  end

  it 'requires business name' do
    lead.business_name = nil
    expect(lead).to_not be_valid
  end

  it 'requires business name to have max 100 chars' do
    lead.business_name = 'B' * 101 
    expect(lead).to_not be_valid
  end

  it 'requires telephone number' do
    lead.telephone_number = nil
    expect(lead).to_not be_valid
  end

  it 'requires telephone number to have max 13 chars' do
    lead.telephone_number = '1' * 14 
    expect(lead).to_not be_valid
  end

  it 'requires email' do
    lead.email = nil
    expect(lead).to_not be_valid
  end

    it 'requires email to have max 80 chars' do
    lead.email = 's' * 81 
    expect(lead).to_not be_valid
  end

end