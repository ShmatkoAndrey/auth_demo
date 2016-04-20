class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_user
    if cookies[:demo_mode] == '0'
      return User.find(session[:user_id]) unless session[:user_id].nil?
    elsif cookies[:demo_mode] == '1'
      return  User.find(cookies[:user_id]) if cookies[:user_id] && !cookies[:user_id].empty?
    elsif cookies[:demo_mode] == '2'
      return  User.where(auth_token: cookies[:auth_token]).first if cookies[:auth_token] && !cookies[:auth_token].empty?
    end
  end

  def user_signed_in?
    if cookies[:demo_mode] == '0'
      return session[:user_id] ? true : false
    elsif cookies[:demo_mode] == '1'
      return !cookies[:user_id].empty? if cookies[:user_id]
    elsif cookies[:demo_mode] == '2'
      return !cookies[:auth_token].empty? if cookies[:auth_token]
    end
  end

  helper_method 'current_user'
  helper_method 'user_signed_in?'
end