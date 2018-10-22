require 'rails_helper'

describe 'Epside Builder Service' do
  it 'should be able to build episodes' do
    VCR.use_cassette('series') do
		  @si = SonarrInterface.new
		  response = @si.get_all_series


      sb = SeriesBuilder.new(response)
      sb.build_all_series
    end

    VCR.use_cassette('episodes') do
      ep_response = @si.get_all_episodes(1)
      eb = EpisodeBuilder.new(ep_response)
      episodes = eb.build_all_episodes

      expect(Episode.count).to eq(30)
    end
  end
end