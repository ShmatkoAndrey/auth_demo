class SessionsController < ApplicationController
  def create
    user = User.find_by_login(params[:login])
    if user && user.password_secret == Digest::SHA256.hexdigest(params[:password])
      session[:user_id] = user.id
      if params[:remember]
        token = Random.new_seed
        cookies[:auth_token] = { value:token, expires: 1.hour.from_now }
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
    session[:user_id] = nil
    cookies[:auth_token] = nil
    flash[:success] = 'User session destroy!'
    redirect_to root_url
  end

  def social_auth
    if params[:social][:error]
      redirect_to :back
    else
      @user = User.find_for_auth(params[:provider], params[:social])
      if @user.nil?
        redirect_to :back
      else
        session[:user_id] = @user.id
        redirect_to root_path
      end
    end
  end
end