require 'rails_helper'

describe 'Sonarr Interface Service' do
  it 'should be able to access Sonarr' do
    VCR.use_cassette('series') do
		  si = SonarrInterface.new
		  response = si.get_all_series

		  expect(response.count).to eq(3)
		  expect(response.first.keys).to include(:path)
    end
  end
end
