class Target < ApplicationRecord
  has_and_belongs_to_many  :games
  has_many :scores
  belongs_to :company, foreign_key: 'company_id'
  mount_base64_uploader :image, ImageUploader
end
