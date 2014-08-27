class DropUsersAndOrganizations < ActiveRecord::Migration
  def change
    drop_table :organizations
    drop_table :users
  end
end
