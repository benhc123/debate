class CreateDelegationEntriesDelegations < ActiveRecord::Migration
  def change
    create_table :delegation_entries_delegations do |t|
      t.belongs_to :delegation, index: true
      t.belongs_to :delegation_entry, index: true

      t.timestamps
    end
  end
end
