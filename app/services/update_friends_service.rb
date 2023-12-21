class UpdateFriendsService < ApplicationService

  def initialize(user_id)
    @user = User.find(user_id)
  end

  def execute
    update_friends
  end

  private

  attr_reader :user

  def update_friends
    following = get_following
    puts following.count
    return false unless following

    UpdateRelationshipsService.execute(user.id, following)
  end

  def get_following
    begin
      res = Typhoeus.get("http://localhost:1111/follows/#{user.npub}")

      if res.code == 200 && JSON.parse(res.body).count > 0
        return JSON.parse(res.body)
      else 
        return false   
      end
    rescue Exception => e
      return false
    end
  end
end
