require 'rails_helper'

describe 'Epside Builder Service' do
  it 'should be able to build episodes' do
    VCR.use_cassette('episde_builder_build') do
      SeriesBuilder.build_all
    end

    VCR.use_cassette('episodes') do
      episodes = EpisodeBuilder.build_all

      expect(Episode.count).to be > 40
    end
  end
end
