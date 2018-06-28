require 'rails_helper'

describe ContactForm do
  let(:contact) { build(:contact_form) }
  let(:stub_swagger_api) { allow_any_instance_of(SwaggerClient).to receive(:create) { { 'errors' => [] } } }

  describe 'when initialised' do
    before { stub_swagger_api }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:business_name) }
    it { is_expected.to validate_presence_of(:telephone_number) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to respond_to(:contact_time) }
    it { is_expected.to respond_to(:notes) }
    it { is_expected.to respond_to(:reference) }
  end

  describe '.save', vcr: false do
    before { stub_swagger_api }

    it 'is truthy' do
      expect(contact.save).to be_truthy
    end

    it 'is falsey' do
      contact = build(:contact_form, name: nil)
      expect(contact.save).to be_falsey
    end
  end

  describe 'message attribute', vcr: false do
    let(:subject) { contact.message }

    before { stub_swagger_api }

    it { is_expected.to be_nil }

    it "is 'Enqueue success' when save succeeded" do
      expect { contact.save }.to change {
                                   contact.message
                                 }.to 'Enqueue success'
    end

    it "is 'Format errors on validation' when save failed" do
      contact.name = nil
      expect { contact.save }.to change {
        contact.message
      }.to 'Format errors on validation'
    end
  end

  describe 'swagger_api_validator_and_storage' do
    it 'calls SwaggerClient' do
      expect_any_instance_of(SwaggerClient).to receive(:create)
      contact.save
    end

    it 'sets server not responding when no result' do
      allow_any_instance_of(SwaggerClient).to receive(:create)

      expect { contact.save }.to change {
        contact.errors.full_messages
      }.to(['Server is not responding'])
    end

    it 'sets no errors when no errors' do
      stub_swagger_api
      contact.save
      expect(contact.errors).to be_empty
    end

    it 'sets spefic error' do
      allow_any_instance_of(SwaggerClient).to receive(:create) { { 'errors' => ['La La Land'] } }
      expect { contact.save }.to change {
        contact.errors.full_messages
      }.to(['La La Land'])
    end
  end
end
