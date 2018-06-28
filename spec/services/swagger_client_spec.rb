require 'rails_helper'

describe SwaggerClient do
  describe '.create' do
    let(:valid_params) { attributes_for(:contact_form) }

    describe 'when success' do
      let(:create) { described_class.new.create(valid_params) }

      it 'calls HTTParty post method', vcr: false do
        expect(described_class).to receive(:post)
        create
      end

      it 'returns success response', vcr: true do
        success_mockup = { 'message' => 'Enqueue success',
                           'errors' => [] }

        expect(create).to eq success_mockup
      end
    end

    describe 'when failure' do
      let(:create) { described_class.new.create(valid_params.merge(name: nil)) }

      it 'returns failure response', vcr: true do
        failure_mockup = { 'errors' =>
          ["Field 'name' is blank", "Field 'name' wrong format, 'name' must be composed with 2 separated words (space between)"], 'message' => 'Format errors on validation' }

        expect(create).to eq failure_mockup
      end
    end
  end
end
