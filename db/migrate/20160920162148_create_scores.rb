class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.string :target_id
      t.string :player_id
      t.string :game_id
      t.string :success
      t.string :score
      t.string :lieu
      t.string :location_gps

      t.belongs_to :user, index: true
      t.belongs_to :target, index: true

      t.timestamps
    end
  end
end
