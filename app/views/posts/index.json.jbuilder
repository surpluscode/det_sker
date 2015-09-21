json.array!(@posts) do |post|
  json.extract! post, :id, :title, :body, :featured
  json.url post_url(post, format: :json)
end
