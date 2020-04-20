class GeocodeService
   def get_data_via_location(location)
     response = conn.get("/maps/api/geocode/json") do |req|
       req.params["address"] = location
     end
     JSON.parse(response.body, symbolize_names: true)
   end
   def get_data_via_latlong(lat, long)
     response = conn.get("/maps/api/geocode/json") do |req|
       req.params["latlng"] = "#{lat}, #{long}"
     end
     JSON.parse(response.body, symbolize_names: true)
   end

   private

     def conn
       Faraday.new("https://maps.googleapis.com") do |req|
         req.params["key"] = ENV["GOOGLE_API_KEY"]
       end
     end
 end
