class User < ApplicationRecord
  has_secure_password

  validates_presence_of :username, :password, :name
  validates_uniqueness_of :username
  validates_length_of :password, minimum: 8
end