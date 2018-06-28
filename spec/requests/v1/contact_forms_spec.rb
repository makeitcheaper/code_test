require 'rails_helper'

describe API::V1::ContactFormsController do
  describe 'POST create' do

    let(:create_action) { post_json '/v1/contact_forms', contact_form: params }

    before do
      allow_any_instance_of(SwaggerClient).to receive(:create) { { 'errors' => [] } }
      create_action
    end

    describe 'with valid params' do
      let(:params) { attributes_for(:contact_form) }

      it 'is JSON' do
        expect(response.content_type).to eql 'application/json'
      end

      it 'is created' do
        expect(response.status).to eql(201) # created
      end

      context 'returns' do
        it 'message' do
          expect(json_response[:message]).to eq 'Enqueue success'
        end

        it 'empty array of errors' do
          expect(json_response[:errors]).to be_empty
        end
      end
    end

    describe 'with invalid params' do
      let(:params) { attributes_for(:contact_form).merge(name: nil) }

      it 'is unprocessed entity' do
        expect(response.status).to eql(422) # unprocessable_entity
      end

      context 'returns' do
        it 'not empty array of errors' do
          expect(json_response[:errors]).to be_a Array
          expect(json_response[:errors]).to be_any
        end

        it 'explained error message' do
          expect(json_response[:errors]).to include("Name can't be blank")
        end

        it 'message' do
          expect(json_response[:message]).to eq 'Format errors on validation'
        end
      end
    end
  end

  describe 'POST create integrated with SwaggerClient' do
    describe 'which is not responding', vcr: false do
      before { post_json '/v1/contact_forms', { contact_form: attributes_for(:contact_form) } }
      
      it 'is unprocessable entity' do
        expect(response.status).to eql(422) # unprocessable_entity
      end

      describe 'response JSON' do
        let(:subject) { json_response }

        it { is_expected.to include message: 'Server is not responding' }
        it { is_expected.to include errors: ['Server is not responding'] }
      end
    end

    describe 'is called with invalid param' do
      let(:invalid_params) { { contact_form: attributes_for(:contact_form, telephone_number: 'La La Land') } }

      before { post_json '/v1/contact_forms', invalid_params }

      it 'is unprocessable entity', vcr: false do
        expect(response.status).to eql(422) # unprocessable_entity
      end

      describe 'response JSON', type: :request, vcr: true do
        let(:subject) { json_response }

        it { is_expected.to include message: 'Format errors on validation' }
        it { is_expected.to include errors: ["Field 'telephone_number' wrong format (must contain have valid phone number with 11 numbers. string max 13 chars)"] }
      end
    end
  end
end
