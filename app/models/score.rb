class Score < ApplicationRecord
  belongs_to :user, foreign_key: 'user'
  belongs_to :target, foreign_key: 'target'
end
