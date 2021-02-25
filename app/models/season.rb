class Season < ApplicationRecord
  belongs_to :team
  has_one :owner, through: :team
  has_many :games
end