FactoryBot.define do
  factory :series do
    title { "MyString" }
    season_count { 1 }
    episode_count { 1 }
    size_on_disk { 12345  }
    path { "MyString" }
    sonarr_id { 1 }
  end
end
