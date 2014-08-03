class CreateDelegationEntries < ActiveRecord::Migration
  def change
    create_table :delegation_entries do |t|
      t.references :delegation, index: true
      t.string :delegate_type
      t.integer :delegate_id
      t.integer :position

      t.timestamps
    end
  end
end
