class User < ApplicationRecord
  has_secure_password

  has_many :teams_owned, class_name: "Team", foreign_key: "owner_id"
  
  has_many :players
  has_many :teams, through: :players
  has_many :games, through: :players
  has_many :goals, through: :players
  has_many :assists, through: :players
  has_many :penalties, through: :players

  validates_presence_of :username, :password, :name
  validates_uniqueness_of :username
  validates_length_of :password, minimum: 8
end