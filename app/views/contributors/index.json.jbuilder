json.array!(@contributors) do |contributor|
  json.extract! contributor, 
  json.url contributor_url(contributor, format: :json)
end
