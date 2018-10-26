class SonarrInterface

	def conn
    Faraday.new(:url => ENV['SONARR_ROUTE'] ) do |f|
      f.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      f.headers['X-Api-Key'] = ENV['SONARR_API_KEY']
    end
  end

  def get(type, series = '')
    request_url = build_request(series)[type]
    parse( conn.get(request_url).body )
  end

  def parse(response_data)
    JSON.parse(response_data, symbolize_names: true)
  end


  def build_request(series_id = '')
    {
      series:       '/api/series',
      episode_file: "/api/episodefile?seriesId=#{series_id}",
      episode:      "/api/episode?seriesId=#{series_id}"
    }
  end

  def get_all_series
    JSON.parse(conn.get('/api/series').body, symbolize_names: true)
  end

  def get_all_episodes(series_id)
    JSON.parse(conn.get("/api/episodefile?seriesId=#{series_id}").body, symbolize_names: true)
  end
end
