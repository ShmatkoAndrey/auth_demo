class ModesController < ApplicationController
  def change
    cookies[:demo_mode] = params[:mode]
    redirect_to root_path
  end
end