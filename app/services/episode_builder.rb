class EpisodeBuilder

  def initialize
    #build_all_episodes
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

  def update_series(series_id)
    get_episodes_for_series(series_id).each do |episode|
      update_episode(episode)
    end
  end

  def update_episode(episode_response)
    ep = Episode.find_or_create_by(unique_id: episode_response[:unique_id]) do |episode|
      episode.update_attributes( series_id: Series.find_by(sonarr_id: episode_response[:seriesId]).id,
                                 unique_id: episode_response[:seriesId].to_s + episode_response[:seasonNumber].to_s + episode_response[:id].to_s,
                                 season:    episode_response[:seasonNumber],
                                 path:      episode_response[:path],
                                 size:      episode_response[:size],
                                 audio:     episode_response[:mediaInfo][:audioCodec],
                                 video:     episode_response[:mediaInfo][:videoCodec],
                                 encoded:   check_encoded( episode_response )
      )

    end
  end

  def build_episode(episode)
    if episode[:seriesId].nil?
      nil
    else
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
  end

  def check_encoded(episode)
    episode[:mediaInfo][:audioCodec] == 'AAC' && episode[:mediaInfo][:videoCodec] == 'x264'
  end
end
