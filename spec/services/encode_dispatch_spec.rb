require 'rails_helper'

describe 'Apollo Interface' do
  it 'should send encode requests to Apollo' do
    VCR.use_cassette('Apollo Encode Request') do
      dest_folder = 'fixtures/video_files/tmp'
      dest_file_path = 'fixtures/video_files/tmp/star_trails.mkv'
      test_file_path = 'fixtures/video_files/star_trails.mkv'
      video_path = 'fixtures/video_files/tmp/star_trails.mkv'
      FileUtils.cp(test_file_path, dest_folder)
      encoded_path = 'fixtures/video_files/tmp/star_trails.mp4'

      episode = create( :episode, path: dest_file_path )

      ed = EncodeDispatch.dispatch( 'http://localhost:4000', 1 )

      expect(ed.status).to eq(204)

    end

  end
end
