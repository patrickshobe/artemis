class EpisodesController < ApplicationController

  def index
    @episodes = Episode.all
  end

  def encode
    episode = Episode.find(params[:id])
    EncoderJob.perform_later(episode.path)
    flash[:notice] = 'Encode Started'
    redirect_to episodes_path
  end
end
