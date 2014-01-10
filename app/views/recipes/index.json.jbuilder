json.array!(@recipes) do |recipe|
  json.extract! recipe, :title, :link, :time, :ingredient, :pantry
  json.url recipe_url(recipe, format: :json)
end
