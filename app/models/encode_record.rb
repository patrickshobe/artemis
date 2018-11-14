class EncodeRecord < ApplicationRecord
  belongs_to :episode

  def self.next_encode
    where(finished_at: nil).order(created_at: :asc).limit(1).first
  end
end
