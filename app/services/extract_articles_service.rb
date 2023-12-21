class ExtractArticlesService < ApplicationService
  include ActionView::Helpers::SanitizeHelper
  include PostRank::URI

  def initialize(event)
    @event = JSON.parse(event)
    return false unless event

    @skipdomain = ['defcon.social', 'twitter.com', 'social.vmbrasseur.com', 'tiktok.com', 'www.tiktok.com', 'techhub.social', 'mastodon.online', 'social.uncommonly.cool', 'www.instagram.com', 'instagram.com', 'socel.net', 'mastodon.art', 'twit.social', 'mstdn.social', 'www.w3.org', 'mastodon.social', 'social.coop', 'google.com', 'indieweb.social', 'github.com', 'w3.org']
  end

  def execute
    extract_articles
  end

  private

  attr_reader :event, :skipdomain

  def extract_articles
    puts "extracting articles"  
    puts "event: #{event}"
    links = []
    puts event['pubkey']
    pubkey = event['pubkey']
    is_repost = event['content']['pubkey'] ? true : false
    puts "is_repost: #{is_repost}"
    if is_repost
      repost = JSON.parse(event['content'])
    end
    event_content = is_repost ? repost['content'] : event['content']
    cleaned_content = strip_tags(event_content)
    puts cleaned_content.inspect
    urls = PostRank::URI.extract(cleaned_content)
    urls.each do |url|
      puts "processing url: #{url}"
      clean_url = PostRank::URI.clean(url)
      uri = Addressable::URI.parse(clean_url)
      next if uri.path.blank? || uri.path == '/'
      query = uri.query ? uri.query : ''
      canonical = uri.host + uri.path + query
      links.append({ :scheme => uri.scheme, :canonical => canonical, :host => uri.host})
    end
    links.each do |link|
      puts "processing link"
      next if link[:scheme].nil?
      next if skipdomain.include? link[:host]

      composed_url = "#{link[:scheme]}://#{link[:canonical]}"
      article = Article.find_by(url: composed_url)
      begin
        unless article
          cache = ActiveSupport::Cache.lookup_store(:file_store, '/tmp/cache')
          page = MetaInspector.new(composed_url, faraday_http_cache: { store: cache }, :headers => {'User-Agent' => 'open.news'})

          next unless page.meta['og:type'] == 'article'
          puts "found an article at #{composed_url}"
          image = page.meta['og:image']
          title = page.best_title
          author = page.best_author
          description = page.best_description
          image_width = page.meta['og:image:width']
          image_height = page.meta['og:image:height']
          pub_date = page.meta['dc.date.issued'] || page.meta['bt.pubdate'] || page.meta['article.published'] || page.meta['pubdate']
          og_url = page.meta['og:url']
          article_data = { url: og_url, image: image, author: author, title: title, description: description, image_width: image_width, image_height: image_height, pub_date: pub_date }
          article = Article.find_by(url: composed_url)
          article = Article.create(url: composed_url, metadata: article_data) unless article
        end
        source = Source.find_by(public_key: pubkey)
        source = Source.create(public_key: pubkey) unless source
        source_article = SourceArticle.find_by(source_id: source.id, article_id: article.id)
        SourceArticle.create(source_id: source.id, article_id: article.id, note: event, is_repost: is_repost) unless source_article
      rescue StandardError => e
        Rails.logger.info "article  processing for #{composed_url} error:#{e.message}"
        next
      end
    end
  end
end
