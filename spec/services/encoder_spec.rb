require 'rails_helper'

describe 'Video Encoder Service' do
  xit 'should encode a video' do

    # Set up files for testing
    dest_folder = 'fixtures/video_files/tmp'
    dest_file_path = 'fixtures/video_files/tmp/star_trails.mkv'
    test_file_path = 'fixtures/video_files/star_trails.mkv'
    video_path = 'fixtures/video_files/tmp/star_trails.mkv'
    FileUtils.cp(test_file_path, dest_folder)
    encoded_path = 'fixtures/video_files/tmp/star_trails.mp4'

    # Set up path
    episode = Episode.new(series_id: 1,
                          season: 1,
                          unique_id: 1,
                          path: dest_file_path,
                          size: 1,
                          audio: 'AAC',
                          video: 'h264')
    Encoder.new(episode)

    expect(File.file?(video_path)).to eq(false)
    expect(File.file?(encoded_path)).to eq(true)
    expect(File.extname(encoded_path)).to eq('.mp4')

    # Clean Up
    File.delete(encoded_path)
  end
end
