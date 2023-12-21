xml.instruct! :xml, :version => "1.0"
xml.rss(:version => "2.0") do
  xml.channel do
    xml.title @title
    xml.description @description
    xml.link root_url

    @top_articles.each do |article|
      xml.item do
        xml.title article.metadata['title']
        xml.description article.metadata['description']
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link article.url
        xml.guid article.url
      end
    end
  end
end
