class EncoderJob < ApplicationJob
  queue_as :default

  def perform(episode)
    Encoder.new(episode)
  end
end

