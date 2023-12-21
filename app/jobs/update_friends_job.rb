class UpdateFriendsJob < ApplicationJob

  def perform(user_id)
    UpdateFriendsService.execute(user_id)
  end
end
