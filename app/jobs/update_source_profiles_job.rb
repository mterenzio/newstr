class UpdateSourceProfilesJob < ApplicationJob

  def perform()
    Source.all.each do |source|
      UpdateSourceProfileJob.perform_later(source.id)
    end
  end
end
