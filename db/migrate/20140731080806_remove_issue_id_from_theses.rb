class RemoveIssueIdFromTheses < ActiveRecord::Migration
  def change
    remove_column :theses, :issue_id, :integer
  end
end
