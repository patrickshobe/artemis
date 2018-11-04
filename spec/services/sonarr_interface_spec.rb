require 'rails_helper'

describe 'Sonarr Interface Service' do
  it 'should command sonarr to rescan for a series' do
    VCR.use_cassette('command') do
      response = EpisodeUpdater.new.send_api_update(1)

      expect(response[:body][:seriesId]).to eq(1)
      expect(response[:body][:completionMessage]).to eq("Completed")
    end
  end
end
