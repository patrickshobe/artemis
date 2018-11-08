class Api::V1::EpisodesController < ApplicationController
  def index
    render json: Episode.all
  end
end
