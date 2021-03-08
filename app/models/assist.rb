class Assist < ApplicationRecord
  belongs_to :player
  belongs_to :goal

  scope :by_player, ->(player) { where(player: player) }
end