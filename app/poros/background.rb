class Background
  def initialize(data)
    @image = data[:photos][0][:src][:landscape]
  end
end
