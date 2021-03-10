class Game < ApplicationRecord
  belongs_to :season
  has_one :owner, through: :season
  has_one :team, through: :season

  has_many :goals
  has_many :on_ice_players, through: :goals
  has_many :assists, through: :goals
  has_many :assist_players, through: :assists
  has_many :penalties

  has_many :game_players
  has_many :players, through: :game_players

  def score
    score_hash = {
      us: self.goals.where(team: team).count,
      opponent: self.goals.where(team: nil).count
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

  def team_stats

  end

  def events
    {
      goals: GoalSerializer.new(self.goals.order(period: :ASC, time: :ASC)).as_json,
      penalties: PenaltySerializer.new(self.penalties.order(period: :ASC, time: :ASC)).as_json
    }
  end

  def player_stats(player)
    stats_hash = {
      goals: self.goals.by_player(player).count,
      assists: self.assists.by_player(player).count,
      plus_minus: self.on_ice_players.where(goals: {team: self.team}, id: player).count - self.on_ice_players.where(goal: {team: nil}, id: player).count,
      pim: self.penalties.by_player(player).sum { |p| p.length }
    }
    stats_hash[:points] = stats_hash[:goals] + stats_hash[:assists]
    stats_hash
  end

  def find_player_by_user(user)
    player = self.team.players.find_by(user: user)
    {
      details: player,
      attending: self.players.include?(player)
    }
  end

  def as_json(options = {})
    puts options
    json_to_return = super
    if options.has_key? :users_player
      player = find_player_by_user(options[:users_player])
      json_to_return[:users_player] = player
    end
    json_to_return
  end

  def players_list
    PlayerSerializer.new(self.players, self).game_player_as_json
  end

  def players_with_stats
    PlayerSerializer.new(self.players, self).game_player_as_json
  end

end
