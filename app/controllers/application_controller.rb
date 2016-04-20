class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :put_params

  private

  def put_params
    puts "#{params.inspect}".red
  end

  def current_user
    # User.find(session[:user_id]) unless session[:user_id].nil?
    User.find(cookies[:user_id]) if cookies[:user_id] && !cookies[:user_id].empty?
  end

  def user_signed_in?
    # session[:user_id] ? true : false
    !cookies[:user_id].empty? if cookies[:user_id]
  end

  helper_method 'current_user'
  helper_method 'user_signed_in?'
end