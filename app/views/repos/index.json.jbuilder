json.array!(@repos) do |repo|
  json.extract! repo, :name, :user_id
  json.url repo_url(repo, format: :json)
end