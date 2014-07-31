class RemovePositionFromTheses < ActiveRecord::Migration
  def change
    remove_column :theses, :position, :integer
  end
end
