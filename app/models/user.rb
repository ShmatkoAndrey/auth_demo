class User < ActiveRecord::Base
  has_many :identities, dependent: :destroy

  validates :login, :presence => true, :uniqueness => {:case_sensitive => false }, length: {maximum: 55}
  validates :password_secret, :presence => true, length: {minimum: 1}

  def self.find_for_auth(provider, auth)
    identity = Identity.find_or_create_by(uid:auth[:id], provider: provider)
    @user = identity.user
    if @user.nil?
        @user = User.create(login: auth[:email], password_secret: Digest::SHA256.hexdigest(Random.new_seed.to_s))
        identity.update(user_id: @user.id)
    end
    @user
  end
end