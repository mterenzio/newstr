class NotesController < ApplicationController

  def note
    @source_article = SourceArticle.where("note->>'id' = ?", params[:note_id]).first if params[:note_id]
    @source = @source_article.source if @source_article
    puts "source: #{@source}"
    render :status => 404 if !@note || !@source and return

    respond_to do |format|
      format.html { render :layout => false }
    end
  end
end