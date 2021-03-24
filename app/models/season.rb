class Season < ApplicationRecord
  belongs_to :team
  has_one :owner, through: :team
  has_many :games, -> { order(datetime: :asc) }
  has_many :players, through: :games

  has_many :goals, through: :games
  has_many :assists, through: :goals
  has_many :on_ice_players, through: :goals

  has_many :penalties, through: :games

  attr_accessor :current

  before_validation :check_set_current

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :team

  def check_set_current
    self.team.update(current_season: self) if @current
    self.team.update(current_season: nil) if !@current && self.current
  end


  def current
    self.team.current_season == self
  end

  def record
    {
      w: self.games.where(win_loss: "W").count,
      l: self.games.where(win_loss: "L").count,
      t: self.games.where(win_loss: "T").count,
      otl: self.games.where(win_loss: ["OTL", "SOL"]).count
    }
  end

  def next_game
    temp = self.games.to_be_played.first
    if temp
      return GameSerializer.new(temp).next_game_as_json
    else
      return nil
    end
  end

  def last_game
    temp = self.games.final.last
    if temp
      return GameSerializer.new(temp).last_game_as_json
    else
      return nil
    end
  end

  def stats(player)
    stats_hash = {
      games_played: self.players.where(id: player.id).count,
      goals: self.goals.where(player: player).count,
      assists: self.assists.where(player: player).count,
      plus_minus: self.on_ice_players.where(goals: {team: self.team}, id: player).count - self.on_ice_players.where(goals: {team: nil}, id: player).count,
      pim: self.penalties.by_player(player).sum{ |penalty| penalty.length }
    }
    stats_hash[:points] = stats_hash[:goals] + stats_hash[:assists]
    stats_hash
  end

  def players_list
    PlayerSerializer.new(self.players.uniq, self).aggregate_stats_as_json
  end

end