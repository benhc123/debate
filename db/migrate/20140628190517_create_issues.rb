class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.text :title
      t.text :text
      t.references :author, index: true

      t.timestamps
    end
  end
end
