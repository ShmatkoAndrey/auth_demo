class User < ActiveRecord::Base
  validates :login, :presence => true, :uniqueness => {:case_sensitive => false }, length: {maximum: 35}
  validates :password_secret, :presence => true, length: {minimum: 1}
end