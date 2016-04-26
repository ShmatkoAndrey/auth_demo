require 'rails_helper'

# bundle exec rake db:migrate
# bundle exec rake test:prepare
# bundle exec rspec spec/models/user_spec.rb

describe User do

  it 'has a valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  before { @user = FactoryGirl.build(:user) }
  subject { @user }

  it { expect respond_to(:login) }
  it { expect be_valid }



  describe 'when login address is already taken' do
    before do
      user2 = @user.dup
      user2.save
    end
    it { expect(@user).not_to be_valid }
  end

  describe 'when login address is already taken with upcase' do
    before do
      user2 = @user.dup
      user2.login = @user.login.upcase
      user2.save
    end
    it { expect(@user).not_to be_valid }
  end

end