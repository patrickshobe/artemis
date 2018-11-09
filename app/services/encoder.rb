class Encoder
  def initialize(raw_video)
    movie = FFMPEG::Movie.new(raw_video.path)
    encode_record = record_begin_encode(raw_video, movie)
    transcoded = movie.transcode(encoded_path(raw_video.path))
    record_end_encode(encode_record, transcoded)
    remove_old_episode(raw_video)
    EpisodeUpdater.update(raw_video)
  end

  def encoded_path(path)
    path.chop.chop.chop + 'mp4'
  end

  def record_begin_encode(episode, movie)
    EncodeRecord.create( episode_id:   episode.id,
                         initial_size: movie.size)
  end

  def record_end_encode(encode_record, transcoded)
    encode_record.update( finished_at: Time.now,
                          final_size:  transcoded.size,
                          success:     transcoded.valid? )
  end

  def remove_old_episode(episode)
    if File.file?(episode.path) && File.extname(episode.path).in?(%w(.mkv .avi))
      File.delete(episode.path)
    end
  end
end
