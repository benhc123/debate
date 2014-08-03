class CreateDelegations < ActiveRecord::Migration
  def change
    create_table :delegations do |t|
      t.references :voter, index: true

      t.timestamps
    end
  end
end
