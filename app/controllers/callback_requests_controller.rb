# frozen_string_literal: true

class CallbackRequestsController < ApplicationController
  def new
    @callback_request = CallbackRequest.new
  end

  def create
    @callback_request = CallbackRequest.new(callback_request_params)

    if @callback_request.save
      flash[:success] = 'Callback Request successfully submitted'

      redirect_to action: :new
    else
      render :new
    end
  end

  private

  def callback_request_params
    params.require(:callback_request).permit(
      :name,
      :business_name,
      :telephone_number,
      :email,
      :notes
    )
  end
end
