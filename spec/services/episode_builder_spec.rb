require 'rails_helper'

describe 'Series Builder Service' do
  it 'should be able to access Sonarr' do
		si = SonarrInterface.new
		response = si.get_all_series

    sb = SeriesBuilder.new(response)
    sb.build_all_series

    expect(Series.count).to eq(2)
  end
end
