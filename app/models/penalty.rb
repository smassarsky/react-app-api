class Penalty < ApplicationRecord
  belongs_to :game
  has_one :owner, through: :game

  belongs_to :player, optional: true
  belongs_to :team, optional: true
  
  validates_presence_of :game_id, :length

  scope :by_player, ->(player) { where(player: player) }
end