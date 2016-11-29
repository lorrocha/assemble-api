class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :profile_text
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
