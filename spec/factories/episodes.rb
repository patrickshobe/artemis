FactoryBot.define do
  factory :episode do
    series                  { create(:series) }
    episode_file_id         { 1 }
    season_number           { 1 }
    episode_number          { 1 }
    title                   { 'title' }
    air_date                    { '2017-01-01' }
    has_file                { true }
    absolute_episode_number { 1 }
    sonarr_id               { 1 }
    path                    { 'path/to/file' }
    size                    { 1234 }
    date_added              { '2017-01-01' }
    audio                   { 'AAC' }
    video                   { 'h264' }
    encoded                 { false }
  end
end
