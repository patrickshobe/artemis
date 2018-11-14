class Worker < ApplicationRecord
  require 'securerandom'
  validates_presence_of :location

  def generate_identity
    access_token = SecureRandom.urlsafe_base64
  end
end
