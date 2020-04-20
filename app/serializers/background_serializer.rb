class BackgroundSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location, :image_url
end
