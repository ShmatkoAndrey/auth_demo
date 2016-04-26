# require 'rails_helper'
#
# describe UsersController, :type => :controller do
#
#   before {
#     @user = FactoryGirl.build(:user)
#     @pass = @user.password_secret
#     @user.password_secret = Digest::SHA256.hexdigest(@pass)
#   }
#   describe 'fill_in form login' do
#     it 'should have content session', js: true do
#       @user.save!
#       visit new_sessions_path
#       fill_in 'Login', with: @user.login
#       fill_in 'Password', with: @pass
#       click_button 'Log in'
#       expect(session[:user_id]).to have_content(@user.id)
#     end
#
#     it 'destroys user session', js: true do
#       @user.save!
#       visit new_sessions_path
#       fill_in 'Login', with: @user.login
#       fill_in 'Password', with: @pass
#       click_button 'Log in'
#       click_link 'Logout'
#       expect(session[:user_id]).not_to have_content(@user.id)
#     end
#   end
#
# end