class Player < ApplicationRecord
  has_one :player_code
  belongs_to :user, optional: true

  belongs_to :team
  has_one :owner, through: :team

  has_many :game_players
  has_many :games, through: :game_players

  has_many :goals
  has_many :assists
  has_many :on_ices

  validates_presence_of :name, :position, :jersey_num, :status
  validates_inclusion_of :position, in: %w(C RW LW D G), message: "Invalid Position"
  validates_inclusion_of :status, in: %w(Active Inactive)
  validates_uniqueness_of :name, scope: :team
  validates_numericality_of :jersey_num, greater_than_or_equal_to: 0, less_than: 100

  before_destroy :dont_delete_owner, prepend: true do
    throw(:abort) if errors.present?
  end

  after_initialize :set_defaults

  scope :active, -> { where(status: 'Active')}
  scope :inactive, -> { where(status: 'Inactive')}

  def set_defaults
    self.position ||= 'C'
    self.jersey_num ||= 0
    self.status ||= 'Active'
  end

  def stats
    stat_hash = {
      games_played: self.games.count,
      goals: self.goals.count,
      assists: self.assists.count,
    }
    stat_hash[:points] = stat_hash[:goals] + stat_hash[:assists]
    stat_hash
  end

  def stats_in_thing(thing)
    stats_hash = {
      games_played: thing.games.where(players: self).count,
      goals: thing.goals.where(player: self).count,
      assists: thing.assists.where(player: self).count
    }
    stats_hash[:points] = stats_hash[:goals] + stats_hash[:assists]
    stats_hash
  end

  def stats_in_game(game)
    stats_hash = {
      goals: game.goals.by_player(self).count,
      assists: game.assists.by_player(self).count,
      plus_minus: game.on_ice_players.where(goals: {team: game.team}, id: self).count - game.on_ice_players.where(goals: {team: nil}, id: self).count,
      pim: game.penalties.by_player(self).sum { |p| p.length }
    }
    stats_hash[:points] = stats_hash[:goals] + stats_hash[:assists]
    stats_hash
  end

  def season_stats(season)
    stats_hash = {
      games_played: season.players.where(id: self).count,
      goals: season.goals.by_player(self).count,
      assists: season.assists.by_player(self).count,
      plus_minus: season.on_ice_players.where(goals: {team: self.team}, id: self).count - season.on_ice_players.where(goals: {team: nil}, id: self).count,
      pim: season.penalties.by_player(self).sum { |p| p.length }
    }
    stats_hash[:points] = stats_hash[:goals] + stats_hash[:assists]
    stats_hash
  end

  def as_json(options = {})
    json_to_return = super
    if options.has_key? :stats
      stats = self.stats_in_thing(options[:stats])
      json_to_return[:stats] = stats
    elsif options.has_key? :game_stats
      stats = self.stats_in_game(options[:game_stats])
      json_to_return[:stats] = stats
    elsif options.has_key? :season_stats
      stats = self.season_stats(options[:season_stats])
      json_to_return[:stats] = stats
    end
    json_to_return
  end

  private

  def dont_delete_owner
    errors.add(:owner, "can't be deleted.") if owner == user
  end

end
