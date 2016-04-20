class SessionsController < ApplicationController
  def create
    user = User.find_by_login(params[:login])
    if user && user.password_secret == Digest::SHA256.hexdigest(params[:password])

      if cookies[:demo_mode] == '0'
        session[:user_id] = user.id

      elsif cookies[:demo_mode] == '1'
        cookies[:user_id] = { value:user.id, expires: 1.hour.from_now }

      elsif cookies[:demo_mode] == '2'
        token = Random.new_seed
        cookies[:auth_token] = { value:token, expires: 1.hour.from_now }
        user.update(auth_token: token)

      elsif cookies[:demo_mode] == '3'
        session[:user_id_auth] = user.id
        token = Random.new_seed
        cookies[:auth_token_session] = { value:token, expires: 1.hour.from_now }
        user.update(auth_token: token)

      end
      flash[:success] = 'User login!'
      redirect_to root_url
    else
      flash[:danger] = 'Login or Password wrong!'
      redirect_to new_sessions_path
    end
  end

  def destroy
    if cookies[:demo_mode] == '0'
      session[:user_id] = nil
    elsif cookies[:demo_mode] == '1'
      cookies[:user_id] = nil
    elsif cookies[:demo_mode] == '2'
      cookies[:auth_token] = nil
    elsif cookies[:demo_mode] == '3'
      session[:user_id_auth] = nil
      cookies[:auth_token_session] = nil
    end
    flash[:success] = 'User session destroy!'
    redirect_to root_url
  end
end