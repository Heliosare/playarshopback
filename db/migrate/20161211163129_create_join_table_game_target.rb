class CreateJoinTableGameTarget < ActiveRecord::Migration[5.0]
  def change
    create_join_table :games, :targets do |t|
      t.index [:game_id, :target_id]
      # t.index [:target_id, :game_id]
    end
  end
end
