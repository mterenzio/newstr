class UsersController < ApplicationController

  def show
    @user = User.find_by(params[:public_key])
  end

  def create
    begin
      @user = User.find_or_create_by!(params[:public_key])
      render :show
    rescue Exception
      flash[:notice] = "User not valid"
      render :new
    end
  end
end