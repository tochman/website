json.array!(@projects) do |project|
  json.extract! project, :title, :body, :created, :public
  json.url project_url(project, format: :json)
end
