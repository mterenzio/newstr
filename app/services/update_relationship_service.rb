class UpdateRelationshipService < ApplicationService
  def initialize(user_id, npub)
    @user = User.find_by(id: user_id)
    @npub = npub
  end

  def execute
    update_relationship
  end

  private

  attr_reader :npub, :user

  def get_public_key(npub)
    res = Typhoeus.get("http://localhost:1111/public_key/#{npub}")
    if res.code == 200
      return JSON.parse(res.body)
    else
      return false
    end
  end

  def update_relationship
    # no sense in making a user source for current user
    return if npub == user.npub

    source = Source.find_by(npub: npub)
    if source
      source.update_attribute(:updated_at,Time.now)
    else
      puts "creating source"
      puts npub
      source = Source.create!(npub: npub, public_key: get_public_key(npub))
    end
    user_source = UserSource.find_by(source_id: source.id, user_id: user.id)
    UserSource.create(user_id: user.id, source_id: source.id) unless user_source
  end
end
