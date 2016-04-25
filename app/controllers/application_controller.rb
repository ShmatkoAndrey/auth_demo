class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_user
    unless @current_user
      if session[:user_id_auth].nil? && cookies[:auth_token_session] && !cookies[:auth_token_session].empty?
        user = User.where(auth_token: cookies[:auth_token_session])
        session[:user_id_auth] = user.first.id unless user.nil?
      else
        @user_find = User.where(id: session[:user_id_auth])
      end
    end
    @current_user ||= @user_find.first unless @user_find.nil?
  end

  def user_signed_in?
    current_user.presence
  end

  helper_method 'current_user'
  helper_method 'user_signed_in?'
end