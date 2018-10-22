FactoryBot.define do
  factory :episode do
    series { nil }
    season { 1 }
    path { "MyText" }
    size { "" }
    audio { "MyString" }
    video { "MyString" }
    encoded { "" }
  end
end
