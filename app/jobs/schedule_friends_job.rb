class ScheduleFriendsJob < ApplicationJob

  def perform
    User.all.each do |user|
      UpdateFriendsJob.perform_later(user.id)
    end
  end
end
