json.array!(@issues) do |issue|
  json.extract! issue, :id, :title, :text, :author_id
  json.url issue_url(issue, format: :json)
end
