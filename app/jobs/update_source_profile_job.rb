class UpdateSourceProfileJob < ApplicationJob

  def perform(source_id)
    UpdateSourceProfileService.execute(source_id)
  end
end
