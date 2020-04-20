class AntipodeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :search_location, :city_name, :forecast
end
