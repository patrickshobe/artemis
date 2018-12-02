class EncodeRecord < ApplicationRecord
  belongs_to :episode

  def self.next_encode
    where(finished_at: nil).order(created_at: :asc).limit(1).first
  end

  def self.encode_counts
    encoded = where(success: true).count
    pending = where(started_at: nil).count
    percent = ((encoded.to_f / pending) * 100).round(2)
    { encoded: encoded,
      pending: pending,
      percent: percent }
  end

  def self.count_by_day
    where(success: true).order("DATE(finished_at)").group("DATE(finished_at)").count
  end
end
