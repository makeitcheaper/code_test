# frozen_string_literal: true

# CallbackController: Logic is contained in the Callbackable concern.
class CallbackController < ApplicationController
  include Callbackable
end
