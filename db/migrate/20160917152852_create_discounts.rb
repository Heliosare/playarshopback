class CreateDiscounts < ActiveRecord::Migration[5.0]
  def change
    create_table :discounts do |t|
      t.string :level
      t.string :success
      t.string :fail
      t.boolean :state
      t.string :game_ref

      t.belongs_to :game, index: true
      t.belongs_to :company, index: true
      t.timestamps
    end
  end
end
