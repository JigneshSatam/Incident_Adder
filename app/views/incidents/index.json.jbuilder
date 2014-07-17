json.array!(@incidents) do |incident|
  json.extract! incident, :id, :mountain, :latitude, :longitude, :when, :title, :description
  json.url incident_url(incident, format: :json)
end
