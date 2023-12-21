class ProcessEventsJob < ApplicationJob

  def perform()
    redis = Redis.new

    while event = redis.rpop('events') do
      ExtractArticlesJob.perform_later(event)
    end
  end
end
