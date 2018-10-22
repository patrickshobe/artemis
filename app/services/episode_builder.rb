class EpisodeBuilder

  def initialize(episodes_response)
    @episodes_response = episodes_response
  end

  def build_all_episodes
    @episodes_response.each do |episode|
      build_episode(episode)
    end
    true
  end

  def build_episode(episode)
    episode = Episode.create( series_id: episode[:seriesId],
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
