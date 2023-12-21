json.version "https://jsonfeed.org/version/1"
json.title @title

json.items @top_articles do |article|
  json.title article.metadata['title']
  json.content_html article.metadata['description']
  json.image article.metadata['image']
  json.url article.url
end
