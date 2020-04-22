class Restaurant
  def initialize(data)
    @name = data[:businesses][0][:name]
    @address = data[:businesses][0][:location][:display_address].join(", ")
  end
end
