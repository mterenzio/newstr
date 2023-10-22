class User < ApplicationRecord
  has_many :user_sources, dependent: :destroy
  has_many :sources, through: :user_sources
  has_many :source_articles, through: :sources
  has_many :articles, -> { distinct }, through: :source_articles

  after_commit :update_friends, on: [:create]

  def update_friends
    puts "Updating friends for #{self.id} #{self.nickname}"
    UpdateFriendsJob.perform_later(self.id)
  end

  def daily_top_articles
    last_digest = 1.day.ago #self.last_digest || 1.day.ago
    self.articles.where("articles.created_at > ?", last_digest).limit(50).order('share_count DESC').order('articles.created_at DESC')
  end
end