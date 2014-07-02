class AddPositionToThesis < ActiveRecord::Migration
  def change
    add_column :theses, :position, :integer
  end
end
