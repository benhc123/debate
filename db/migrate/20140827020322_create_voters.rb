class CreateVoters < ActiveRecord::Migration
  def change
    create_table :voters do |t|
      t.string :type
      t.string :name
      t.string :email
      t.string :encrypted_password
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer :sign_in_count
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip
      t.integer :role

      t.timestamps
    end
  end
end
