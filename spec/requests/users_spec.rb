require 'rails_helper'

describe 'Users', :type => :request do
  before {
    @user = FactoryGirl.build(:user)
    @pass = @user.password_secret
    @user.password_secret = Digest::SHA256.hexdigest(@pass)
  }

  describe 'GET rooth_path' do
    it 'works!', js: true do
      get root_path
      expect(response).to have_http_status(200)
    end

    it 'should have the content "Id"', js: true do
      visit root_path
      expect(page).to have_content('Id')
    end

    it 'should have the content user login', js: true do
      @user.save!
      visit root_path
      expect(page).to have_content(@user.login)
    end

    it 'should have the content user id', js: true do
      @user.save!
      visit root_path
      expect(page).to have_content(@user.id)
    end

    it 'should have the content Login', js: true do
      visit root_path
      expect(page).to have_content('Login')
    end

    it 'should have the content Hi, Guest', js: true do
      visit root_path
      expect(page).to have_content('Hi, Guest')
    end

    it 'should have the content Sign up', js: true do
      visit root_path
      expect(page).to have_content('Sign up')
    end
  end

  describe 'show errors' do
    it 'should have content empty login error', js: true do
      visit new_users_path
      fill_in 'Login', with: ''
      fill_in 'Password', with: @user.password_secret
      fill_in 'Password confirmation', with: @user.password_secret
      click_button 'Create User'
      expect(page).to have_content('Login can\'t be blank')
    end

    it 'should have content pass != pass_confirm', js: true do
      visit new_users_path
      fill_in 'Login', with: @user.login
      fill_in 'Password', with: @user.password_secret
      fill_in 'Password confirmation', with: 'foobar'
      click_button 'Create User'
      expect(page).to have_content('Invalid pass or pass != confirmation')
    end

    it 'should have content dup login', js: true do
      @user.save!
      visit new_users_path
      fill_in 'Login', with: @user.login
      fill_in 'Password', with: @user.password_secret
      fill_in 'Password confirmation', with: @user.password_secret
      click_button 'Create User'
      expect(page).to have_content('Login has already been taken')
    end

    it 'should have content login is too long', js: true do
      visit new_users_path
      fill_in 'Login', with: 'example'*25
      fill_in 'Password', with: @user.password_secret
      fill_in 'Password confirmation', with: @user.password_secret
      click_button 'Create User'
      expect(page).to have_content('Login is too long')
    end

    it 'should have content Login or Password wrong!', js: true do
      visit new_sessions_path
      fill_in 'Login', with: ''
      fill_in 'Password', with: ''
      click_button 'Log in'
      expect(page).to have_content('Login or Password wrong!')
    end
  end

  describe 'form sign up' do
    it 'should have the field Login', js: true do
      visit new_users_path
      expect(page).to have_field('Login')
    end

    it 'should have the field Password', js: true do
      visit new_users_path
      expect(page).to have_field('Password')
    end

    it 'should have the field Password confirmation', js: true do
      visit new_users_path
      expect(page).to have_field('Password confirmation')
    end

    it 'should have the button Create user!', js: true do
      visit new_users_path
      expect(page).to have_button('Create User')
    end
  end

  describe 'fill_in form signup' do
    it 'should be +1 after registration', js: true do
      visit new_users_path
      fill_in 'Login', with: @user.login
      fill_in 'Password', with: @user.password_secret
      fill_in 'Password confirmation', with: @user.password_secret
      expect do
        click_button 'Create User'
      end.to change(User, :count).by(1)
    end

    it 'should have the content login', js: true do
      visit new_users_path
      fill_in 'Login', with: @user.login
      fill_in 'Password', with: @user.password_secret
      fill_in 'Password confirmation', with: @user.password_secret
      click_button 'Create User'
      expect(page).to have_content(@user.login)
    end

    it 'should not be +1 after registration (pass != pass_confirmation)', js: true do
      visit new_users_path
      fill_in 'Login', with: @user.login
      fill_in 'Password', with: @user.password_secret
      fill_in 'Password confirmation', with: 'foobar'
      expect do
        click_button 'Create User'
      end.not_to change(User, :count)
    end

    it 'should not be +1 after registration (login is to long)', js: true do
      visit new_users_path
      fill_in 'Login', with: 'example'*20
      fill_in 'Password', with: @user.password_secret
      fill_in 'Password confirmation', with: @user.password_secret
      expect do
        click_button 'Create User'
      end.not_to change(User, :count)
    end

    it 'should not be +1 after registration (login is empty)', js: true do
      visit new_users_path
      fill_in 'Login', with: ''
      fill_in 'Password', with: @user.password_secret
      fill_in 'Password confirmation', with: @user.password_secret
      expect do
        click_button 'Create User'
      end.not_to change(User, :count)
    end

    it 'should be registration, redirect and have content login new user', js: true do
      visit new_users_path
      fill_in 'Login', with: @user.login
      fill_in 'Password',with: @user.password_secret
      fill_in 'Password confirmation', with: @user.password_secret
      click_button 'Create User'
      expect(page).to have_content(@user.login)
    end

  end

  describe 'form login' do
    it 'should have the field Login', js: true do
      visit new_sessions_path
      expect(page).to have_field('Login')
    end

    it 'should have the field Password', js: true do
      visit new_sessions_path
      expect(page).to have_field('Password')
    end

    it 'should have the button Log in', js: true do
      visit new_sessions_path
      expect(page).to have_button('Log in')
    end

    it 'should have the button Sign up', js: true do
      visit new_sessions_path
      expect(page).to have_content('Sign up')
    end
  end

  describe 'fill_in form login' do
    it 'should have content Hi, login', js: true do
      @user.save!
      visit new_sessions_path
      fill_in 'Login', with: @user.login
      fill_in 'Password', with: @pass
      click_button 'Log in'
      expect(page).to have_content("Hi, #{@user.login}")
    end

     it 'should have content Logout', js: true do
      @user.save!
      visit new_sessions_path
      fill_in 'Login', with: @user.login
      fill_in 'Password', with: @pass
      click_button 'Log in'
      expect(page).to have_content('Logout')
    end
  end

  describe 'logout' do
    it 'should be destroys user session', js: true do
      @user.save!
      visit new_sessions_path
      fill_in 'Login', with: @user.login
      fill_in 'Password', with: @pass
      click_button 'Log in'
      click_link 'Logout'
      expect(page).not_to have_content('Logout')
    end

    it 'should be destroys user session and have content Hi, Guest', js: true do
      @user.save!
      visit new_sessions_path
      fill_in 'Login', with: @user.login
      fill_in 'Password', with: @pass
      click_button 'Log in'
      click_link 'Logout'
      expect(page).to have_content('Hi, Guest')
    end
  end

  # describe 'social buttons facebook' do
  #   before { @fb_user = {email: 'erygjoz_laustein_1461688220@tfbnw.net', password: '456369'} }
  #
  #   it 'invalid password facebook', js: true do
  #     visit new_sessions_path
  #     sleep 1.second
  #     find('#fb-button').click
  #     sleep 5.second
  #     while page.driver.browser.window_handles.length == 1
  #       sleep 5.seconds
  #     end
  #     within_window('Facebook') do
  #       fill_in 'email', with: @fb_user[:email]
  #       fill_in 'pass', with: 'xx'
  #       find('#loginbutton').click
  #     end
  #     sleep 2.second
  #     expect(page).to have_content('Hi, Guest')
  #   end
  #
  #   it 'facebook click cancel button', js: true do
  #     visit new_sessions_path
  #     sleep 1.second
  #     find('#fb-button').click
  #     sleep 5.second
  #     while page.driver.browser.window_handles.length == 1
  #       sleep 5.seconds
  #     end
  #     within_window('Facebook') do
  #       click_button 'Cancel'
  #     end
  #     sleep 2.second
  #     expect(page).to have_content('Hi, Guest')
  #   end
  #
  #   it 'login and redirect', js: true do
  #     visit new_sessions_path
  #     sleep 1.second
  #     find('#fb-button').click
  #     sleep 5.second
  #     while page.driver.browser.window_handles.length == 1
  #       sleep 5.seconds
  #     end
  #     within_window('Facebook') do
  #       fill_in 'email', with: @fb_user[:email]
  #       fill_in 'pass', with: @fb_user[:password]
  #       find('#loginbutton').click
  #     end
  #     sleep 2.second
  #     expect(page).to have_content("Hi, #{@fb_user[:email]}")
  #   end
  # end
end