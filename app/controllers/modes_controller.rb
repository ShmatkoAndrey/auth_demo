class ModesController < ApplicationController
  def change
    cookies[:demo_mode] = (params[:mode].to_i - 1)
    redirect_to root_path
  end
end