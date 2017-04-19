class Game < ApplicationRecord
  belongs_to :company, foreign_key: 'company_id'
  has_and_belongs_to_many  :target
  has_one :discount
  has_one :game_list
  mount_base64_uploader :image, ImageUploader
end
