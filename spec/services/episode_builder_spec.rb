require 'rails_helper'

describe 'Epside Builder Service' do
  it 'should be able to build episodes' do
    VCR.use_cassette('episde_builder_build') do
      sb = SeriesBuilder.new
      sb.build_all_series
    end

    VCR.use_cassette('episodes') do
      eb = EpisodeBuilder.new
      episodes = eb.build_all_episodes

      expect(Episode.count).to be > 40
    end
  end
end
