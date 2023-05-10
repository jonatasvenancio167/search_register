class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :telephone
      t.string :email
      t.string :biography
      t.date :birthdate
      t.string :activation_code
      t.boolean :activated, default: false
      t.string :password
      t.string :password_confirmation
      t.string :password_digest

      t.timestamps
    end
  end
end
