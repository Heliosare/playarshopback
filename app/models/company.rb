class Company < ApplicationRecord
  belongs_to :users
  has_many :games
  has_many :targets
  has_many :discounts
  mount_base64_uploader :logo, ImageUploader
end
