class EncoderJob < ApplicationJob
  queue_as :default

  def perform(path)
    movie = FFMPEG::Movie.new(path)
    transcoded = movie.transcode("tmp/movie.mp4")

  end
end
