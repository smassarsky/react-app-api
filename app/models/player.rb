class Player < ApplicationRecord
  has_one :player_code
  belongs_to :user

  belongs_to :team
  has_one :owner, through: :team

  has_many :game_players
  has_many :games, through: :game_players

  has_many :goals
  has_many :assists
  has_many :on_ices
end