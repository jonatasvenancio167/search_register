require 'bcrypt'

class User < ApplicationRecord
  has_secure_password

  validates :activation_code, uniqueness: true
  validates :password, confirmation: true
end
