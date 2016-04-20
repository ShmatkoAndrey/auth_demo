class SessionsController < ApplicationController
  def create
    user = User.find_by_login(params[:login])
    # session[:user_id] = user.id if user && user.password_secret == Digest::SHA256.hexdigest(params[:password])
    cookies[:user_id] = user.id if user && user.password_secret == Digest::SHA256.hexdigest(params[:password])
    flash[:success] = "User session create! #{cookies[:user_id]}"
    redirect_to root_url
  end

  def destroy
    # session[:user_id] = nil
    cookies[:user_id] = nil
    flash[:success] = 'User session destroy!'
    redirect_to root_url
  end
end