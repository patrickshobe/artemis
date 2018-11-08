class EpisodeBuilder

  def initialize
    #build_all_episodes
  end

  def get_episode_info(series_id)
    SonarrInterface.new.get(:episode, series_id)
  end

  def get_episode_file_info(episode_file_id)
    SonarrInterface.new.get(:episode_file, episode_file_id)
  end

  def build_all_info(series_id)
    eliminate_missing_episodes(series_id).each do |episode|
      series = Series.find(series_id)
      Episode.create!( series: series,
                      episode_file_id: episode[:episodeFileId],
                      season_number: episode[:seasonNumber],
                      episode_number: episode[:episodeNumber],
                      title: episode[:title],
                      air_date: episode[:airDate],
                      has_file: episode[:hasFile],
                      absolute_episode_number: episode[:absoluteEpisodeNumber],
                      sonarr_id: episode[:id],
                      path: episode[:episodeFile][:path],
                      size: episode[:episodeFile][:size],
                      date_added: episode[:episodeFile][:dateAdded],
                      audio:     episode[:episodeFile][:mediaInfo][:audioCodec],
                      video:     episode[:episodeFile][:mediaInfo][:videoCodec],
                      encoded:   check_encoded( episode[:episodeFile] ))
    end
  end

  def eliminate_missing_episodes(series_id)
      get_episode_info(series_id).select do |episode|
        binding.pry if episode.nil?
          episode[:hasFile]
    end
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

  def check_encoded(episode)
    episode[:mediaInfo][:audioCodec] == 'AAC' && episode[:mediaInfo][:videoCodec] == 'x264'
  end
end
