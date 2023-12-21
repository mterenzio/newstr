class ExtractArticlesJob < ApplicationJob

  def perform(event)
    ExtractArticlesService.execute(event)
  end
end