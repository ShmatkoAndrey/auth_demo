class ModesController < ApplicationController
  def change
    cookies[:demo_mode] = { value:params[:mode], expires: 1.hour.from_now }
    redirect_to root_path
  end
end