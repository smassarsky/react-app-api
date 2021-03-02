class Game < ApplicationRecord
  belongs_to :season
  has_one :owner, through: :season
  has_one :team, through: :season

  has_many :goals
  has_many :assists, through: :goals
  has_many :penalties

  has_many :game_players
  has_many :players, through: :game_players

  def score
    score_hash = {
      us: goals.where(team: team).count,
      opponent: goals.where.not(team: team).count
    }
    if status == "Final"
      if score_hash[:us] > score_hash[:opponent]
        score_hash[:outcome] = "Win"
      elsif goals.in_shootout.count > 0
        score_hash[:outcome] = "S/O Loss"
      elsif goals.in_ot.count > 0
        score_hash[:outcome] = "OT Loss"
      else
        score_hash[:outcome] = "Loss"
      end
    end
    score_hash
  end

end