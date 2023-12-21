class UpdateSourceProfileService < ApplicationService
  def initialize(source_id)
    @source = Source.find(source_id)
  end

  def execute
    update_source_profile
  end

  private

  attr_reader :source

  def update_source_profile
    return false unless source

    begin
      res = Typhoeus.get("http://localhost:1111/profile/#{source.npub}")

      if res.code == 200 && JSON.parse(res.body).count > 0
        source.update_attribute(:profile, JSON.parse(res.body))
      else 
        return false   
      end
    rescue
      return false
    end
  end
end
