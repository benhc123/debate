class AddPositionToDelegation < ActiveRecord::Migration
  def change
    add_column :delegations, :position, :integer
  end
end
