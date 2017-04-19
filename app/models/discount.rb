class Discount < ApplicationRecord
    belongs_to :game, foreign_key: 'game'
    belongs_to :company, foreign_key: 'company_id'
end
