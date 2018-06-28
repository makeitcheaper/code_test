# frozen_string_literal: true

module API
  module V1
    class ContactFormsController < API::V1::BaseController
      def create
        contact_form = ContactForm.new(contact_params)
        if contact_form.save
          render json: {
            message: contact_form.message,
            errors: []
          }, status: :created
        else
          render json: {
            message: contact_form.message,
            errors: contact_form.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      private

      def contact_params
        params.require(:contact_form).permit(*ContactForm::ATTRIBUTES)
      end
    end
  end
end
