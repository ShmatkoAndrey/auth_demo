class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :put_params

  private

  def put_params
    # cookies[:demo_mode] = 0 if cookies[:user_id].nil? || cookies[:user_id].empty?
    puts "#{cookies[:demo_mode]}".green
    puts "#{params.inspect}".green
    puts "session[:user_id] = #{session[:user_id]}".red
    puts "cookies[:user_id] = #{cookies[:user_id]}".red

    puts '---'.brown.bold
  end

  def current_user
    if cookies[:demo_mode] == '0'
      return User.find(session[:user_id]) unless session[:user_id].nil?
    elsif cookies[:demo_mode] == '1'
      return  User.find(cookies[:user_id]) if cookies[:user_id] && !cookies[:user_id].empty?
    end
  end

  def user_signed_in?
    if cookies[:demo_mode] == '0'
      return session[:user_id] ? true : false
    elsif cookies[:demo_mode] == '1'
      return !cookies[:user_id].empty? if cookies[:user_id]
    end
  end

  helper_method 'current_user'
  helper_method 'user_signed_in?'
end