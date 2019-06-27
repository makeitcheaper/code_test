# frozen_string_literal: true

RSpec.describe MakeItCheaperService do
  describe 'save_lead' do
    context 'when everything is good (201)' do
      it "doesn't add any errors to the given lead" do

      end

      it 'returns true' do

      end
    end

    xcontext 'when status is 401 bad request' do
      it 'adds validation errors to the given lead' do

      end

      it 'returns false' do

      end
    end

    context 'when status is 400' do
      expect { subject }.to raise_error
    end

    context 'when status is 500' do
      subject { described_class.save_lead() }

      before do
        allow(described_class).to receive(:api_options).and_return({

        })
      end

      expect { subject }.to raise_error(MakeItCheaperService::ApiError)
    end
  end
end
