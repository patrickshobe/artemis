class Api::V1::EncodeRecordsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    EncodeDispatch.dispatch( ENV['WORKER_1'], params[:format] )
  end

  def update
    encode = EncodeRecord.find(params[:id])
    encode.update( finished_at: Time.now,
                   success: true)
    EpisodeUpdater.update(encode.episode)
  end
end
