class Api::V1::EncodeRecordsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    EncodeRecord.create(episode_id: params[:format])
  end

  def index
    render json: EncodeRecordFacade.all
  end

  def update
    encode = EncodeRecord.find(params[:id])
    worker = Worker.find_by( access_token: request.headers['IDENTITY'])
    encode.update( finished_at: Time.now,
                   success: true)
    EpisodeUpdaterJob.perform_later(encode.episode)
    EncodeDispatch.dispatch( worker.id )
  end

  # Non Restful Methods

  def encodes_by_day
    render json: EncodeRecord.count_by_day
  end

  def encode_numbers
    render json: EncodeRecord.encode_counts
  end
end
