class UpdateAuthorSetJob < ApplicationJob

  def perform()
    redis = Redis.new
    Source.all.each do |source|
      redis.sadd('authors', source.npub)
    end
  end
end
