class Api::V1::BackgroundsController < ApplicationController
  def show
    background = BackgroundFacade.new(params[:location])
  end
end
