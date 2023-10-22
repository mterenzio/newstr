class SourceArticle < ApplicationRecord
  belongs_to :article, counter_cache: :share_count
  belongs_to :source
end