class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_user
    if cookies[:demo_mode] == '0'
      @user_find = User.where(id: session[:user_id]) unless session[:user_id].nil?
    elsif cookies[:demo_mode] == '1'
      @user_find = User.where(id: cookies[:user_id]) if cookies[:user_id] && !cookies[:user_id].empty?
    elsif cookies[:demo_mode] == '2'
      @user_find = User.where(auth_token: cookies[:auth_token]) if cookies[:auth_token] && !cookies[:auth_token].empty?
    elsif cookies[:demo_mode] == '3'
      @user_find = User.where(id: session[:user_id_auth]) unless session[:user_id_auth].nil?
    end
    @current_user ||= @user_find.first unless @user_find.nil?
  end

  def user_signed_in?
    current_user.presence
  end

  helper_method 'current_user'
  helper_method 'user_signed_in?'
end