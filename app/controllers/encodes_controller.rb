class EncodesController < ApplicationController
  def index
    @encodes = EncodeRecord.all
  end
end
