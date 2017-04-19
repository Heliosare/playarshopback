class CreateGameLists < ActiveRecord::Migration[5.0]
  def change
    create_table :game_lists do |t|
      t.string :name
      t.text :description
      t.string :image
      # t.text :level, :share, :string
      t.text :level,  array: true, default: [] 
      

      t.belongs_to :game, index: true
      t.timestamps
    end
  end
end