class CreateTheses < ActiveRecord::Migration
  def change
    create_table :theses do |t|
      t.references :issue, index: true
      t.text :summary
      t.text :text
      t.references :author, index: true

      t.timestamps
    end
  end
end
