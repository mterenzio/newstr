class User < ApplicationRecord
  has_many :user_sources, dependent: :destroy
  has_many :sources, through: :user_sources
  has_many :source_articles, through: :sources
  has_many :articles, -> { distinct }, through: :source_articles

  after_commit :initialize_user, on: [:create]

  scope :daily_email_subscribers, -> { where(subscribed_daily_email: true).where.not(email: nil) }

  def initialize_user
    UpdateFriendsJob.perform_later(self.id)
    redis = Redis.new
    if redis.sadd?('authors', self.public_key)
      puts "Added #{self.public_key} to authors"
      redis.publish('authors.ping', self.public_key)
    end
  end

  def daily_top_articles
    last_digest = 1.day.ago #self.last_digest || 1.day.ago
    self.articles.where("articles.created_at > ?", last_digest).limit(50).order('share_count DESC').order('articles.created_at DESC')
  end
end