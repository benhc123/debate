class IssueVersion < VestalVersions::Version
  def pretty_created_at
    created_at.in_time_zone.to_s(:pretty)
  end
end
