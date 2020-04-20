class Api::V1::BackgroundsController < ApplicationController
  def show
    data = BackgroundService.new.get_data(params["location"])
    image_url = Background.new(data)
  end
end
