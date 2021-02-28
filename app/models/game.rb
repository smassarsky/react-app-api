class Game < ApplicationRecord
  belongs_to :season
  has_one :owner, through: :season

  has_many :goals
  has_many :assists, through: :goals
  has_many :penalties

  has_many :game_players
  has_many :players, through: :game_players
end