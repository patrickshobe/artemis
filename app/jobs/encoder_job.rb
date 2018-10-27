class EncoderJob < ApplicationJob
  queue_as :default

  def perform(episode)
    movie = FFMPEG::Movie.new(episode.path)
    encode_record = record_begin_encode(episode, movie)
    transcoded = movie.transcode(encoded_path(episode.path))
    record_end_encode(encode_record, transcoded)
    remove_old_episode(episode)
  end

  private

  def encoded_path(path)
    path.chop.chop.chop + 'mp4'
  end

  def record_begin_encode(episode, movie)
    EncodeRecord.create( episode_id:   episode.id,
                         initial_size: movie.size)
  end

  def record_end_encode(encode_record, transcoded)
    encode_Record.update( finished_at: Time.now,
                          final_size:  transcoded.size,
                          success:     transcoded.valid? )
  end

  def remove_old_episode(episode)
#    if File.file?(episode.path) && File.extname(episode.path).in?(%w(.mkv .avi))
      File.delete(episode.path)
#    end
  end
end

