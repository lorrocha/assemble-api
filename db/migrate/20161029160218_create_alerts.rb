class CreateAlerts < ActiveRecord::Migration[5.0]
  def change
    create_table :alerts do |t|
      t.string :alert_text
      t.integer :user_id
      t.integer :team_id

      t.timestamps
    end
  end
end
