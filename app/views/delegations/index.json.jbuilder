json.array!(@delegations) do |delegation|
  json.extract! delegation, :id, :voter_id
  json.url delegation_url(delegation, format: :json)
end
