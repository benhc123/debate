class AddVoterTypeToDelegations < ActiveRecord::Migration
  def change
    add_column :delegations, :voter_type, :string
  end
end
