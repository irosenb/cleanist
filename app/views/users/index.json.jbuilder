json.array!(@users) do |user|
  json.extract! user, :name, :token, :platform
  json.url user_url(user, format: :json)
end
