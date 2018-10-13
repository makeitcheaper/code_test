# frozen_string_literal: true
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action  :verify_authenticity_token
  before_action :errors

  def errors
    @errors = session[:errors]
    session.delete(:errors)
  end
end
