# frozen_string_literal: true

module APIErrorResponses
  def respond_unauthorized
    render json: {
      errors: [{ message: 'You need to sign in or sign up before continuing.' }],
      status: '401', title: 'Unauthorized',
      links: [{ about: Rails.application.routes.url_for(controller: 'users/sessions', action: 'new') }]
    }, status: :unauthorized
  end

  def respond_not_authorized
    render json: {
      errors: [{ message: 'You are not authorized to access this resource.' }],
      status: '403', title: 'Forbidden'
    }, status: :forbidden
  end

  def respond_not_found
    render json: {
      errors: [{ message: 'Not found.' }],
      status: '404', title: 'Not found'
    }, status: :not_found
  end

  def respond_unprocessable_entity(errors = ['No params provided'])
    render json: {
      errors: errors.map do |error|
        { message: error }
      end,
      status: '422', title: 'Unprocessable entity'
    }, status: :unprocessable_entity
  end
end
