class Goal < ApplicationRecord
  belongs_to :game
  has_one :owner, through: :game
  
  belongs_to :player
  has_one :user, through: :player
  has_many :assists
  has_many :assist_players, through: :assists, foreign_key: "player_id"

  belongs_to :team

  has_many :on_ices
  has_many :on_ice_players, through: :on_ices, foreign_key: "player_id"

  scope :in_ot, -> { where("period > 3") }
  scope :in_shootout, -> { where("period = 99") }
end