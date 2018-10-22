class SeriesBuilder

  def initialize(series_response)
    @series_response = series_response
  end

  def build_all_series
    @series_response.each do |series|
      build_series(series)
    end
    true
  end

  def build_series(series)
    series = Series.create(title: series[:title],
                        sonarr_id: series[:id],
                        season_count: series[:seasonCount],
                        episode_count: series[:episodeCount],
                        size_on_disk: series[:sizeOnDisk],
                        path: series[:path])
  end
end
