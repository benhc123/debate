class RemoveIssueIdFromTheses < ActiveRecord::Migration
  def up
    Thesis.all.each do |thesis|
      method = thesis.position == 0 ? :add_thesis_for : :add_thesis_against
      issue_id = thesis.read_attribute(:issue_id)
      issue = Issue.find(issue_id)
      issue.send(method, thesis)
    end
    remove_column :theses, :issue_id, :integer
  end

  def down
    add_column :theses, :issue_id, :integer
  end
end
