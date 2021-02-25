class Team < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :players
  has_many :users, through: :players

  has_many :seasons
  has_many :games, through: :seasons

  has_many :goals
  has_many :penalties

  validates_presence_of :owner, :name
end