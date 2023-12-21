class UpdateRelationshipsService < ApplicationService
  def initialize(user_id, following)
    @user_id = user_id
    @following = following
  end

  def execute
    update_relationships
  end

  private

  attr_reader :following, :user_id

  def update_relationships
    return if following.empty? || following.nil?

    following.each do |npub|
      UpdateRelationshipService.execute(user_id, npub)
    end
  end
end
