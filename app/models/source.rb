class Source < ApplicationRecord
  has_many :user_sources, dependent: :destroy
  has_many :users, through: :user_sources
  has_many :source_articles, dependent: :destroy
  has_many :articles, through: :source_articles

  def deactivate
    self.active = true
    self.save!
  end
end