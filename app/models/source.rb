class Source < ApplicationRecord
  has_many :user_sources, dependent: :destroy
  has_many :users, through: :user_sources
  has_many :source_articles, dependent: :destroy
  has_many :articles, through: :source_articles

  validates :public_key, presence: true, uniqueness: true

  after_create :update_profile_and_authors

  def deactivate
    self.active = true
    self.save!
  end

  def update_profile_and_authors
    UpdateSourceProfileJob.perform_later(self.id)
    redis = Redis.new
    redis.sadd('authors', self.npub)
  end
end