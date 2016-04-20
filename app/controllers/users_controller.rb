class UsersController < ApplicationController

  def index
    @users = User.all.order('created_at DESC');
  end

  def new
    @user = User.new
  end

  def create
    user_params = params[:user]
    if user_params[:password] == user_params[:password_confirmation]
      @user = User.new(login: user_params[:login], password_secret: Digest::SHA256.hexdigest(user_params[:password]))
      if @user.save
        # session[:user_id] = @user.id
        cookies[:user_id] = @user.id
        flash[:success] = 'User create!'
        redirect_to root_url
      end
    end
  end

  def show
  end
end