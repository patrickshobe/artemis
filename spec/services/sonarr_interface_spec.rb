require 'rails_helper'

describe 'Sonarr Interface Service' do
  it 'should be able to access Sonarr' do
		si = SonarrInterface.new
		response = si.get_all_series

		expect(response.count).to eq(2)
		expect(response.first.keys).to include("path")

  end
end
