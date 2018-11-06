require 'rails_helper'

describe 'Sonarr Interface Service' do
  it 'should command sonarr to rescan for a series' do

    VCR.use_cassette("command_series_builder") do
      sb = SeriesBuilder.new
      sb.build_all_series
    end

    VCR.use_cassette('command', :allow_unused_http_interactions => false) do
      response = EpisodeUpdater.update(1)

      expect(response).to be_a(Series)
    end
  end
end
