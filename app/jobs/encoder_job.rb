class EncoderJob < ApplicationJob
  queue_as :default

  def perform(path)
    movie = FFMPEG::Movie.new(path)
    transcoded = movie.transcode(encoded_path(path))
  end

  private

  def encoded_path(path)
    path.chop.chop.chop + 'mp4'
  end
end
