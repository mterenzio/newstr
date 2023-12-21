class ScheduleDailyNewsJob < ApplicationJob

  def perform
    User.daily_subscribers.each do |user|
      DailyNewsJob.perform_later(user.id)
    end
  end
end
