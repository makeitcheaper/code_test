module V1
  class Base < Grape::API
    version 'v1', using: :path
    format :json

    rescue_from Grape::Exceptions::ValidationErrors do |e|
      error! e, 422
    end

    mount V1::Leads
  end
end
