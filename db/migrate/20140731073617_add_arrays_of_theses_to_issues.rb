class AddArraysOfThesesToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :thesis_for_ids, :integer, array: true, default: []
    add_column :issues, :thesis_against_ids, :integer, array: true, default: []
  end
end
