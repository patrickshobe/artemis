require 'rails_helper'

describe 'Series Builder Service' do
  it 'should be able to access Sonarr' do
    VCR.use_cassette("series_builder_series") do
      sb = SeriesBuilder.new
      sb.build_all_series

    expect(Series.count).to eq(3)
    end
  end
end
