require_relative './validations/min_length'
require_relative './validations/max_length'

class API < Grape::API
  format :json
  prefix :api

  mount ::API::V1::Base
end
