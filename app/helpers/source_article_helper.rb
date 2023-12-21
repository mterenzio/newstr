module SourceArticleHelper
  def note_link(source_article)
    puts "source_article: #{source_article.inspect}"
    if source_article.is_repost
      source_article.note['content']['pubkey']
    else
      source_article.note['pubkey']
    end
  end

  def note_content(source_article)
    puts "source_article: #{source_article.inspect}"
    if source_article.is_repost
      repost_content = JSON.parse(source_article.note['content'])
      repost_content['content']
    else
      source_article.note['content']
    end
  end

  def profile_image(source)
    if source.profile['image']
      source.profile['image']
    else
      '/images/default_profile.jpeg'
    end
  end
end