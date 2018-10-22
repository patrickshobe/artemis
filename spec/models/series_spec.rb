require 'rails_helper'

RSpec.describe Series, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :path }
  it { should validate_presence_of :episode_count }
  it { should validate_presence_of :size_on_disk }
  it { should validate_presence_of :season_count }
end
