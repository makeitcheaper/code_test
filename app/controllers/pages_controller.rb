class PagesController < ApplicationController
  def index
    @lead = Lead.new
  end
end
