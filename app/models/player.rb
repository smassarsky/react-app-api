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

  def as_json(options = {})
    json_to_return = super
    if options.has_key? :stats
      stats = self.stats_in_thing(options[:stats])
      json_to_return[:stats] = stats
    end
    json_to_return
  end

  private

  def dont_delete_owner
    errors.add(:owner, "can't be deleted.") if owner == user
  end

end


def as_json(options = {})
  json_to_return = super
  if options.has_key? :translatedCity
    city_translation = self.translatedCity(options[:translatedCity][:language])
    json_to_return[:translatedCity] = city_translation
  end

  return json_to_return
end