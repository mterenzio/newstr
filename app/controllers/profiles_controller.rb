class ProfilesController < ApplicationController

  def profile
    @source = Source.find_by(npub: params[:npub]) if params[:npub]
    render :status => 404 if !@source and return

    respond_to do |format|
      format.html { render :layout => 'daily_news' }
    end
  end
end