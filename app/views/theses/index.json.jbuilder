json.array!(@theses) do |thesis|
  json.extract! thesis, :id, :issue_id, :summary, :text, :author_id
  json.url thesis_url(thesis, format: :json)
end
