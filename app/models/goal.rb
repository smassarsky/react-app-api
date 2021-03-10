class Goal < ApplicationRecord
  belongs_to :game
  has_one :owner, through: :game
  
  belongs_to :player, optional: true
  has_one :user, through: :player
  has_many :assists
  has_many :assist_players, through: :assists, source: 'player'

  belongs_to :team, optional: true

  has_many :on_ices
  has_many :on_ice_players, through: :on_ices, source: 'player'

  scope :in_regulation, -> { where()}
  scope :in_ot, -> { where("period > 3").where.not("period = 99") }
  scope :in_shootout, -> { where("period = 99") }
  scope :by_player, ->(player) { where(player: player) }

  validates_presence_of :period
end