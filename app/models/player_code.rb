class PlayerCode < ApplicationRecord
  belongs_to :player
  has_one :team, through: :player

  attribute :code, :string, default: -> {SecureRandom.hex}

  validates_presence_of :player
  validates_uniqueness_of :player, :code
end