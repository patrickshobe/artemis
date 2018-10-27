FactoryBot.define do
  factory :episode do
    series { 1 }
    season { 1 }
    path { "MyText" }
    size { 123456 }
    audio { "MyString" }
    video { "MyString" }
    encoded { false }
    unique_id { '12345' }
  end
end
