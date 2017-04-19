class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string  :company_name, null: false, default: ""
      t.string  :user_name, null: false, default: ""
      t.string  :first_name, null: false, default: ""
      t.string  :last_name, null: false, default: ""
      t.string  :adress, null: false, default: ""
      t.string  :image, null: false, default: ""
      t.string  :token, null: false, default: ""
      t.string  :phone, null: false, default: ""
      t.string  :function, null: false, default: ""
      t.string  :about, null: false, default: ""

      # t.references :user_type, polymorphic: true, index: true


      t.timestamps
    end
  end
end
