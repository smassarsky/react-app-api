class PlayerCode < ApplicationRecord
  belongs_to :player

  attribute :code, :string, default: -> {SecureRandom.hex}

  validates_presence_of :player, :status
  validates_uniqueness_of :player, :code
end