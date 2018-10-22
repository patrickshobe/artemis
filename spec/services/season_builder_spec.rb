require 'rails_helper'

describe 'Season Builder Service' do
  it 'should be able to build Seasons' do
    VCR.use_cassette("series") do
		  si = SonarrInterface.new
		  response = si.get_all_series


    sb = SeriesBuilder.new(response)
    sb.build_all_series

    expect(Series.count).to eq(3)
    end
  end
end
