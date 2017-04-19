class CreateTargets < ActiveRecord::Migration[5.0]
  def change
    create_table :targets do |t|
      t.string :vuforia_name
      t.string :transaction_id
      t.string :target_id
      t.string :image
      t.string :path
      t.string :place
      t.string :city
      t.string :discountChance
      t.string :discountRate

      t.belongs_to :company, index: true
      t.belongs_to :game, index: true
      t.timestamps
    end
  end
end
