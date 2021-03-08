class GamePlayer < ApplicationRecord
  belongs_to :game
  belongs_to :player

  validates_uniqueness_of :player, scope: :game, message: 'is already attending.'
end