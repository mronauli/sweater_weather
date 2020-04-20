class BackgroundFacade
  attr_reader :location, :image_url, :id
  def initialize(location)
    @location = location
    @image_url = Background.new(background_data)
    @id = nil
  end

  def background_data
    BackgroundService.new.get_data(location)
  end
end
