require 'rails_helper'

RSpec.describe Episode, type: :model do
  it { should validate_presence_of :season }
  it { should validate_presence_of :path }
  it { should validate_presence_of :size }
  it { should validate_presence_of :audio }
  it { should validate_presence_of :video }

  it {should belong_to :series }
end
