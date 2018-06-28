# frozen_string_literal: true

module API
  module V1
    class BaseController < ActionController::Base
      include APIErrorResponses

      rescue_from(ActiveRecord::RecordNotFound) { respond_not_found }
      rescue_from(ActionController::ParameterMissing) { respond_unprocessable_entity }

      protect_from_forgery
    end
  end
end
