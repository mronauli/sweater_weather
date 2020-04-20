class Api::V1::AntipodesController < ApplicationController
  def show
    antipode = AntipodeFacade.new(params["location"])
  end
end
