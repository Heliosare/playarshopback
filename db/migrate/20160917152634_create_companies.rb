class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :logo
      t.string :siret
      t.string :location
      t.string :description
      t.string :address
      t.string :phone
      t.string :lat
      t.string :lng

      t.belongs_to :company_id, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
