class EpisodeBuilder

  def initialize
    build_all_episodes
  end

  def build_all_episodes
    get_all_episodes.flatten.each do |episode|
      build_episode(episode)
    end
  end

  def get_episodes_for_series(series_id)
    SonarrInterface.new.get(:episode_file, series_id)
  end

  def get_all_episodes
    response = []
    Series.all.each do |series|
      response << get_episodes_for_series(series.id)
    end
    response
  end


  def build_episode(episode)
    binding.pry if episode[:seriesId].nil?
    Episode.create(
      series_id: Series.find_by(sonarr_id: episode[:seriesId]).id,
      unique_id: episode[:seriesId].to_s + episode[:seasonNumber].to_s + episode[:id].to_s,
                              season:    episode[:seasonNumber],
                              path:      episode[:path],
                              size:      episode[:size],
                              audio:     episode[:mediaInfo][:audioCodec],
                              video:     episode[:mediaInfo][:videoCodec],
                              encoded:   check_encoded( episode ))

  end

  def check_encoded(episode)
    episode[:mediaInfo][:audioCodec] == 'AAC' && episode[:mediaInfo][:videoCodec] == 'x264'
  end
end
