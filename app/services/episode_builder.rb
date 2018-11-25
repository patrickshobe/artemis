class EpisodeBuilder

  def self.build_all
    Series.all.each do |series|
      new.build_for_series(series.id)
    end
  end

  def self.update_all
    Series.all.each do |series|
      new.update_for_series(series.id)
    end
  end

  def update_for_series(series_id)
    eliminate_missing_episodes(series_id).each do |episode|
      series = Series.find(series_id)
      Episode.find_or_initialize_by(sonarr_id: episode[:id]).update_attributes(
                      series:           series,
                      episode_file_id:  episode[:episodeFileId],
                      season_number:    episode[:seasonNumber],
                      episode_number:   episode[:episodeNumber],
                      title:            episode[:title],
                      air_date:         episode[:airDate],
                      has_file:         episode[:hasFile],
                      absolute_episode_number: episode[:absoluteEpisodeNumber],
                      sonarr_id:        episode[:id],
                      path:             episode[:episodeFile][:path],
                      size:             episode[:episodeFile][:size],
                      date_added:       episode[:episodeFile][:dateAdded],
                      audio:     episode[:episodeFile][:mediaInfo][:audioCodec],
                      video:     episode[:episodeFile][:mediaInfo][:videoCodec],
                      encoded:          check_encoded( episode[:episodeFile] ),
                      file_type:             get_filetype(episode))
    end
  end


  def build_for_series(series_id)
    eliminate_missing_episodes(series_id).each do |episode|
      series = Series.find(series_id)
      Episode.create( series:           series,
                      episode_file_id:  episode[:episodeFileId],
                      season_number:    episode[:seasonNumber],
                      episode_number:   episode[:episodeNumber],
                      title:            episode[:title],
                      air_date:         episode[:airDate],
                      has_file:         episode[:hasFile],
                      absolute_episode_number: episode[:absoluteEpisodeNumber],
                      sonarr_id:        episode[:id],
                      path:             episode[:episodeFile][:path],
                      size:             episode[:episodeFile][:size],
                      date_added:       episode[:episodeFile][:dateAdded],
                      audio:     episode[:episodeFile][:mediaInfo][:audioCodec],
                      video:     episode[:episodeFile][:mediaInfo][:videoCodec],
                      encoded:          check_encoded( episode[:episodeFile] ),
                      file_type:             get_filetype(episode))
    end
  end

  def self.update_episode(episode)
    updated_info = new.get_episode(episode.sonarr_id)
    episode.update(
                    episode_file_id:  updated_info[:episodeFileId],
                    season_number:    updated_info[:seasonNumber],
                    episode_number:   updated_info[:episodeNumber],
                    title:            updated_info[:title],
                    air_date:         updated_info[:airDate],
                    has_file:         updated_info[:hasFile],
                    absolute_episode_number: updated_info[:absoluteEpisodeNumber],
                    sonarr_id:        updated_info[:id],
                    path:             updated_info[:episodeFile][:path],
                    size:             updated_info[:episodeFile][:size],
                    date_added:       updated_info[:episodeFile][:dateAdded],
                    audio:     updated_info[:episodeFile][:mediaInfo][:audioCodec],
                    video:     updated_info[:episodeFile][:mediaInfo][:videoCodec],
                    encoded:          true,
                    file_type:             get_filetype(episode))
  end

  def get_episodes(series_id)
    SonarrInterface.new.get(:episodes, series_id)
  end

  def get_episode(episode_id)
    SonarrInterface.new.get(:episode, episode_id)
  end

  def eliminate_missing_episodes(series_id)
      get_episodes(series_id).select do |episode|
          episode[:hasFile]
    end
  end

  def check_encoded(episode)
    episode[:mediaInfo][:audioCodec] == 'AAC' && episode[:mediaInfo][:videoCodec] == 'h264'
  end

  def get_filetype(episode)
    episode[:episodeFile][:path].chars.last(3).join
  end
end
