# frozen_string_literal: true

describe LeadsController do
  describe 'GET /new' do
    subject { get :new }

    it 'renders the new template' do
      subject

      expect(response).to render_template(:new)
    end
  end

  describe 'POST /create' do
    subject { post :create, params: { lead_form: params } }

    context 'valid params' do
      let(:params) do
        {
          name: 'Name',
          business_name: 'Business name',
          telephone_number: '123',
          email: 'email@example.com'
        }
      end

      it 'redirects to new lead page' do
        subject

        expect(response).to redirect_to(new_lead_path)
      end

      it 'sets notice flash message' do
        subject

        expect(flash[:notice]).to eq('Thank you, The Company will contact you shortly.')
      end
    end

    context 'invalid params' do
      let(:params) { { name: 'Name' } }

      it 'renders the new template' do
        subject

        expect(response).to render_template(:new)
      end

      it 'sets alert flash message' do
        subject

        expect(flash[:alert]).to eq('An error occured.')
      end
    end
  end
end
