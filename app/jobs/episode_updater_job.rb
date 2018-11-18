class EpisodeUpdaterJob < ApplicationJob
  queue_as :default

  def perform(episode)
    EpisodeUpdater.update(episode)
  end
end
