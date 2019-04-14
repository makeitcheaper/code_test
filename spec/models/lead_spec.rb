require 'rails_helper'

RSpec.describe Lead do

  let!(:lead) do
   Lead.new(name: 'John Smith', business_name: 'Bank', 
   telephone_number: '02222333444', email: 'smith@bank.co.uk')
  end

  it 'is valid' do 
    expect(lead).to be_valid
  end

  it 'has right attributes' do
    expect(lead.name).to eq 'John Smith'
    expect(lead.business_name).to eq 'Bank'
    expect(lead.telephone_number).to eq '02222333444'
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

  it 'requires name to be composed with separated words' do
    lead.name = 'JohnSmith' 
    expect(lead).to_not be_valid
  end

  it 'requires name to be composed with at least words' do
    lead.name = 'John' 
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

  it 'requires telephone to have valid UK number with no more than 11 numbers' do
    lead.telephone_number = '077123123123'
    expect(lead).to_not be_valid
  end

  it 'requires telephone to have valid UK number' do
    lead.telephone_number = '07712312312'
    expect(lead).to be_valid
  end

  it 'accepts space in phone number' do
    lead.telephone_number = '07712 312 312'
    expect(lead).to be_valid
  end

  it 'accepts dash in phone number' do
    lead.telephone_number = '07712-312-312'
    expect(lead).to be_valid
  end

  it 'requires no more than 11 digits' do
    lead.telephone_number = '07712-3126312'
    expect(lead).to_not be_valid
  end

  it 'requires exactly 11 digits' do
    lead.telephone_number = '0771231231'
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