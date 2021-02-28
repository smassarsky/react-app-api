class Season < ApplicationRecord
  belongs_to :team
  has_one :owner, through: :team
  has_many :games

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
    wins = self.games.where(win_loss: "win").count
    losses = self.games.where(win_loss: "loss").count
    otl = self.games.where(win_loss: "otl").count
    "#{wins} - #{losses} - #{otl}"
  end

  def next_game

  end

  def last_game

  end

end