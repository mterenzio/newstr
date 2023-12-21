class DailyNewsJob < ApplicationJob

  def perform(user_id)
    DailyNewsMailer.email(user_id).deliver_later!
  end
end
