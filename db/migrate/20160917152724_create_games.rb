class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :ref
      t.string :name
      t.string :description
      t.string :logo
      t.string :image
      t.string :color1
      t.string :color2
      t.string :perso1
      t.string :perso2
      t.string :custom
      # t.string :discount
      t.string :vuforia_name

      t.belongs_to :company, index: true
      t.belongs_to :target, index: true
      t.timestamps
    end
  end
end
