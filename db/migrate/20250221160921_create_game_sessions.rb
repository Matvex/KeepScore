class CreateGameSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :game_sessions do |t|
      t.integer :user_id, null: false
      t.string :name1, limit: 16
      t.string :name2, limit: 16
      t.string :name3, limit: 16
      t.string :name4, limit: 16
      t.integer :total_points1, null: false, default: 0, limit: 5
      t.integer :total_points2, null: false, default: 0, limit: 5
      t.integer :total_points3, null: false, default: 0, limit: 5
      t.integer :total_points4, null: false, default: 0, limit: 5

      t.timestamps
    end

    add_index :game_sessions, :id
  end
end
