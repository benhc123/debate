json.array!(@delegation_entries) do |delegation_entry|
  json.extract! delegation_entry, :id, :delegation_id, :delegate_type, :delegate_id, :position
  json.url delegation_entry_url(delegation_entry, format: :json)
end
