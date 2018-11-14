FactoryBot.define do
  factory :worker do
    name { "apollo" }
    location { "http://localhost:3100" }
    access_token { "boring_token" }
  end
end
