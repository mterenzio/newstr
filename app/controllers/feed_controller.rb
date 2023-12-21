class FeedController < ApplicationController

  def feed
    @user = User.find_by(npub: params[:npub]) if params[:npub]
    render :status => 404 if !@user

    @top_articles = @user.daily_top_articles.includes(:source_articles)

    @title = 'My Personal Nostr News Feed'
    @description = 'The latest news, personalized for you.'
    @feed_url = "https://newstr.news/feed/<%= @rss_token %>.rss"
    @page_url = "https://newstr.news/feed/<%= @rss_token %>"

    respond_to do |format|
      format.html { render :layout => false }
      format.rss { render :layout => false }
      format.atom { render :layout => false }
      format.json { render :layout => false }
    end
  end

  def public
    @top_articles = Article.limit(100).order('share_count DESC').order('articles.created_at DESC')

    @title = 'Front Page'
    @description = 'The latest firehose of news.'
    @feed_url = "https://newstr.social/public.rss"
    @page_url = "https://newstr.social/public"

    respond_to do |format|
      format.html { render :layout => 'daily_news'}
      format.rss { render :layout => false }
      format.atom { render :layout => false }
      format.json { render :layout => false }
    end
  end
end