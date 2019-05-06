# frozen_string_literal: true

module Callbackable
  extend ActiveSupport::Concern

  def index
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.valid?
      @callback = CallbackService.call(@customer)
      render :index unless @callback.response&.success?
    else
      render :index
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :business_name, :telephone_number, :email, :notes, :reference)
  end
end
