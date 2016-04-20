class User < ActiveRecord::Base
  validates :login, :presence => true, :uniqueness => {:case_sensitive => false }
end