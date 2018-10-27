require 'rails_helper'

describe 'Season Builder Service' do
  it 'should be able to build Seasons' do
    VCR.use_cassette("season_builder_series") do
      sb = SeriesBuilder.new
     sb.build_all_series

    expect(Series.count).to eq(3)
    end
  end
end
