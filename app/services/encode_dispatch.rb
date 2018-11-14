class EncodeDispatch

  def initialize( worker_id )
    @worker_id = worker_id
  end

  def self.dispatch( worker )
    dispatcher = new( worker )
    dispatcher.dispatch_job
  end

  def dispatch_job
    update_encode_record
    ApolloInterface.quick_post( worker.location, build_post_body)
  end

  def update_encode_record
    next_encode.update( workers_id: worker.id,
                        started_at: Time.now,
                        initial_size: video.size )
  end

  def video
    @video ||= next_encode.episode
  end

  def build_post_body
    { id:   next_encode.id,
      path: video.path }.to_json
  end

  def next_encode
    @encode ||= EncodeRecord.next_encode
  end

  def worker
    @worker ||= Worker.find(@worker_id)
  end
end
