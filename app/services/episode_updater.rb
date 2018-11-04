class EpisodeUpdater

  def send_api_update(series_id)
    si = SonarrInterface.new
    si.post(build_post_body(series_id))
  end

  def build_post_body(series_id)
    {
      'name'     => 'RescanSeries',
      'seriesId' => series_id
    }.to_json
  end
end
