class UsersController < ApplicationController

  def login
    render
  end

  def authenticate
    begin
      res = Typhoeus.get("http://localhost:1111/profile/#{params[:npub]}")
      puts res.code 
      puts JSON.parse(res.body).count
      if res.code == 200 && JSON.parse(res.body).count > 0
        @user = User.first_or_initialize(npub: params[:npub], profile: JSON.parse(res.body))
        if @user.save!
          session[:user_id] = @user.id
          redirect_to root_path
        else
          flash[:notice] = "User not saved"
          redirect_to "/login"
        end
      else 
        flash[:notice] = "User not found."
        redirect_to "/login"     
      end
    rescue Exception => e
      puts e
      flash[:notice] = "User not valid"
      redirect_to "/login"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  def show
    @user = User.find_by(id: session[:user_id])
    if @user
      redirect_to feed_path
    else
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:npub)
  end
end