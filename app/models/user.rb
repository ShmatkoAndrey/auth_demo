class User < ActiveRecord::Base
  has_many :identities

  validates :login, :presence => true, :uniqueness => {:case_sensitive => false }, length: {maximum: 35}
  validates :password_secret, :presence => true, length: {minimum: 1}

  def self.find_for_auth(provider, auth)
    identity = Identity.find_for_auth(auth[:id], provider)
    @user = identity.user

    if @user.nil?
        @user = User.create(login: auth[:email], password_secret: Digest::SHA256.hexdigest(Random.new_seed.to_s))
    end

    if identity.user != @user
      identity.user = @user
      identity.save!
    end
    @user
  end
end