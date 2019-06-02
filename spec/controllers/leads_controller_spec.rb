# frozen_string_literal: true

describe LeadsController do
  describe 'GET /new' do
    subject { get :new }

    it 'renders the new template' do
      subject

      expect(response).to render_template(:new)
    end
  end
end
