class EncodeDispatch

  def initialize( path, video_id )
    @path = path
    @video_id = video_id
    @record = nil
  end

  def self.dispatch( path, video_id )
    dispatcher = new( path, video_id )
    dispatcher.dispatch_job
  end

  def dispatch_job
    create_encode_record
    ApolloInterface.quick_post( @path, build_post_body)
  end

  def create_encode_record
    @record = EncodeRecord.create( episode:      video,
                                   initial_size: video.size )
  end

  def video
    @video ||= Episode.find( @video_id )
  end

  def build_post_body
    { id:   @record.id,
      path: video.path }.to_json
  end
end
