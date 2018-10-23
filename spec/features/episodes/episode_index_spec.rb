require 'rails_helper'

describe 'Visit Episode Index' do
  it 'should show episodes' do


    series = create(:series)
    episode = create(:episode, series: series)
    visit episodes_path

    expect(page).to have_content(episode.path)
    expect(page).to have_content(episode.encoded)
    expect(page).to have_content(episode.audio)
    expect(page).to have_content(episode.video)
  end
end
