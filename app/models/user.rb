class User < ApplicationRecord
  has_secure_password

  has_many :teams_owned, class_name: "Team", foreign_key: "owner_id"
  
  has_many :players
  has_many :teams, through: :players
  has_many :team_games, -> { order(datetime: :asc) }, through: :teams, source: "games"
  has_many :games, -> { order(datetime: :asc) }, through: :players
  has_many :goals, through: :players
  has_many :assists, through: :players
  has_many :penalties, through: :players

  validates_presence_of :username, :password, :name
  validates_uniqueness_of :username
  validates_length_of :password, minimum: 8

  def upcoming_games
    out = self.team_games.where('games.datetime > ? AND games.status = ?', DateTime.now, 'TBP').limit(5)
    GameSerializer.new(out).upcoming_as_json
  end

  def recent_games
    out = self.games.where('games.datetime < ? AND games.status = ?', DateTime.now, 'Final').limit(5)
    GameSerializer.new(out).recent_as_json
  end

end