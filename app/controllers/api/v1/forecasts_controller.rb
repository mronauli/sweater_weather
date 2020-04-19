class Api::V1::ForecastsController < ApplicationController
  def show
    forecast = ForecastFacade.new(params["location"])
  end
end
