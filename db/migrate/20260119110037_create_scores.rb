class CreateScores < ActiveRecord::Migration[8.0]
  def change
    create_table :scores do |t|
      t.references :game_session, foreign_key: true, null: false
      t.string :player_name, limit: 16, null: false
      t.boolean :won, null: false

      t.timestamps
    end

    add_index :scores, [:game_session_id, :created_at]
  end
end
