class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :email
      t.string :provider, null: false
      t.string :uid, null: false

      t.timestamps
    end
  end
end
