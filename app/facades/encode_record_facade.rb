class EncodeRecordFacade

  def format(encode_record)
    { title: encode_record.episode.title,
      series: encode_record.episode.series.title,
      season: encode_record.episode.season_number,
      episode: encode_record.episode.episode_number }
  end

  def build_all_records
    EncodeRecord.where(success: true).order(finished_at: :desc).map do |record|
      format(record)
    end
  end

  def self.all
    new.build_all_records
  end
end
