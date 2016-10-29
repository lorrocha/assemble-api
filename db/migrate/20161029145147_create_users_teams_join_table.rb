class CreateUsersTeamsJoinTable < ActiveRecord::Migration[5.0]
  create_join_table :users, :teams, column_options: { null: true }
end
