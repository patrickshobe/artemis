require 'rails_helper'

RSpec.describe Worker, type: :model do
  it {should validate_presence_of :location }
end
