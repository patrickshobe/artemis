class TvBuilderJob< ApplicationJob
  queue_as :default

  def perform
    build_series
    build_episodes
  end

  private

  def build_series
    series_builder = SeriesBuilder.new
    series_builder.build_all_series
  end

  def build_episodes
    Series.all.each do |series|
      EpisodeBuilder.new.build_all_episodes
    end
  end
end
