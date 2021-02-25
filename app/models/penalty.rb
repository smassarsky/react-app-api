class Penalty < ApplicationRecord
  belongs_to :game
  belongs_to :player
  belongs_to :team
  
  validates_presence_of :game_id, :team_id, :length
end