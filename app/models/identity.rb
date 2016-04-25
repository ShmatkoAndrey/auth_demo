class Identity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider

  def self.find_for_auth(uid, provider)
    find_or_create_by(uid: uid, provider: provider)
  end
end
