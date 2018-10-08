require 'rails_helper'

RSpec.describe MakeItEasyValidator do
  let(:validator) { MakeItEasyValidator.new(form_inputs) }
  let(:form_inputs) {
    {
      "name" => name,
      "business_name" => business_name,
      "telephone_number" => telephone_number,
      "email" => email
    }
  }
  
  let(:name) { 'Adrian Booth' }
  let(:business_name) { 'Sir Adrian Booth' }
  let(:telephone_number) { '07811111111'}
  let(:email) { 'test@testing.com' }
  
  describe '#validate' do
    context 'valid inputs' do
      it 'returns no errors when all inputs are valid' do
        validator.validate
        expect(validator.errors.messages).to eq({})
      end
    end
    
    context 'invalid inputs' do
      before do
        validator.validate
      end

      context 'when name is blank' do
        let(:name) { '' }
 
        it 'returns an array containing a hash with an error' do
          expect(validator.errors[:name]).to include("can't be blank")
        end
      end
      
      context 'when business name is blank' do
        let(:business_name) { '' }

        it 'returns an array containing a hash with an error' do
          expect(validator.errors[:business_name]).to include("can't be blank")
        end 
      end
      
      context 'when telephone_number is blank' do
        let(:telephone_number) { '' }

        it 'returns false when telephone number is blank' do
          expect(validator.errors[:telephone_number]).to include("can't be blank")
        end
      end

      
      it 'returns false when telephone number is invalid' do
        
      end
      
      it 'returns false when email is blank' do
        
      end
      
      it 'returns false when email is invalid' do
        
      end
    end
  end
end