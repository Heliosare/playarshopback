class User < ApplicationRecord
  has_secure_password
  has_many :company
  has_many :scores
  mount_base64_uploader :image, ImageUploader
end
