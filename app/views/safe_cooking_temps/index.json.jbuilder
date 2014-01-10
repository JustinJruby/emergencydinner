json.array!(@safe_cooking_temps) do |safe_cooking_temp|
  json.extract! safe_cooking_temp, :group, :meat_type, :temp, :note
  json.url safe_cooking_temp_url(safe_cooking_temp, format: :json)
end
