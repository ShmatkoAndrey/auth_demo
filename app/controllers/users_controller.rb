class UsersController < ApplicationController

  def index
    @users = User.all.order('created_at DESC')
    @current_user = current_user
  end

  def new
    @user = User.new
  end

  def create
    if !params[:user][:password].empty? && params[:user][:password] == params[:user][:password_confirmation]
      @user = User.new(login: params[:user][:login], password_secret: Digest::SHA256.hexdigest(params[:user][:password]))
      if @user.save
        session[:user_id] = @user.id
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
end