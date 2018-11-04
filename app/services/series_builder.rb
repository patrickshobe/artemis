class SeriesBuilder

  def self.build_all
    new.build_all_series
  end

  def build_all_series
    get_series.each do |series|
      build_series(series)
    end
  end

  def get_series
    SonarrInterface.new.get(:series)
  end

  def build_series(series)
    Series.create(title: series[:title],
                  sonarr_id: series[:id],
                  season_count: series[:seasonCount],
                  episode_count: series[:episodeCount],
                  size_on_disk: series[:sizeOnDisk],
                  path: series[:path])

  end
end
