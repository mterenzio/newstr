atom_feed({'xmlns:app' => 'http://www.w3.org/2007/app'}) do |feed|
  feed.title(@title)
  feed.url(root_url)

  @top_articles.each do |article|
    feed.entry(article, :url=>article.url) do |entry|
      entry.title(article.metadata['title'])
      entry.url(article.url)
      entry.content(article.metadata['description'], type: 'html')
      entry.tag!('app:edited', Time.now)
    end
  end
end
  
