require 'rails_helper'

RSpec.describe CreateLeadService do
  let(:create_lead_service) { CreateLeadService.new }

  describe '#validate' do
    context 'when validation is successful' do
      before do
        allow_any_instance_of(MakeItEasyValidator).to receive(:valid?).and_return(true)
        allow_any_instance_of(MakeItEasyClient).to receive(:create_lead).and_return(response)
      end

      let(:response) { double('Response', :success? => true) }

      it 'returns a Success result object' do
        expect(create_lead_service.call({'params' => 'valid params'}).class).to eq(Dry::Monads::Result::Success)
      end
    end

    context 'when validation is unsuccessful' do
      before do
        allow_any_instance_of(MakeItEasyValidator).to receive(:valid?).and_return(false)
      end

      it 'returns a Failure result object' do
        expect(create_lead_service.call({'params' => 'invalid params'}).class).to eq(Dry::Monads::Result::Failure)
      end
    end
  end

  describe '#call_api' do
    before do
      allow_any_instance_of(MakeItEasyValidator).to receive(:valid?).and_return(true)
      allow_any_instance_of(MakeItEasyClient).to receive(:create_lead).and_return(response)
    end

    context 'when the api call is successful' do
      let(:response) { double('Response', :success? => true) }

      it 'returns a Success result object' do
        expect(create_lead_service.call({'params' => 'valid params'}).class).to eq(Dry::Monads::Result::Success)
      end
    end

    context 'when the api call is unsuccessful' do
      let(:response) { double('Response', :success? => false, errors: {error_message: 'error'}) }

      it 'returns a Failure result object' do
        expect(create_lead_service.call({'params' => 'invalid params'}).class).to eq(Dry::Monads::Result::Failure)
      end
    end
  end
end