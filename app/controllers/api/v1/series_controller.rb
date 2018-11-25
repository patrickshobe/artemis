class Api::V1::SeriesController < ApplicationController
  def index
    render json: Series.all
  end
end
