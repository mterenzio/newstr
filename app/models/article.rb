class Article < ApplicationRecord
  has_many :source_articles
  has_many :sources, through: :source_articles
  has_many :user_sources, through: :sources
  has_many :users, through: :user_sources

  extend FriendlyId
  friendly_id :title, use: :slugged
end