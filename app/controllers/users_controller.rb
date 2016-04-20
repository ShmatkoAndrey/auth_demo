class UsersController < ApplicationController

  def index
    @users = User.all.order('created_at DESC');
  end

  def new
    @user = User.new
  end

  def create
    user_params = params[:user]
    if !user_params[:password].empty? && user_params[:password] == user_params[:password_confirmation]
      @user = User.new(login: user_params[:login], password_secret: Digest::SHA256.hexdigest(user_params[:password]))
      if @user.save
        session[:user_id] = @user.id if cookies[:demo_mode] == '0'
        cookies[:user_id] = @user.id if cookies[:demo_mode] == '1'
        flash[:success] = 'User create!'
        redirect_to root_url
      else
        flash[:danger] = @user.errors.full_messages.join(';')
        redirect_to new_users_path
      end
    else
      flash[:danger] = 'Invalid pass or pass != confirmation'
      redirect_to new_users_path
    end
  end

  def show
  end
end