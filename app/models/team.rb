class Team < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :players
  has_many :users, through: :players

  has_many :seasons
  has_many :games, through: :seasons

  belongs_to :current_season, class_name: "Season", optional: true

  has_many :goals
  has_many :penalties

  validates_presence_of :owner, :name
  validates_uniqueness_of :name, scope: :owner_id

  def owner_name
    { owner_name: self.owner.name }
  end

  def current_season_name
    self.current_season ? self.current_season.name : "-"
  end

  def current_record
    self.current_season ? self.current_season.record : "-"
  end

  def next_game
    self.current_season ? self.current_season.next_game : "-"
  end

  def last_game
    self.current_season ? self.current_season.last_game : "-"
  end

  def roster
    {
      active: PlayerSerializer.new(self.players.active).roster_as_json,
      inactive: PlayerSerializer.new(self.players.inactive).roster_as_json
    }
  end

end