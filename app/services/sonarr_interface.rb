class SonarrInterface

	def conn
    Faraday.new(:url => ENV['SONARR_ROUTE'] ) do |f|
      f.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      f.headers['X-Api-Key'] = ENV['SONARR_API_KEY']
    end
  end

  def get(type, series = '', body = '')
    request_url = build_request(series)[type]
    response = conn.get(request_url) do |req|
      req.body = body
    end
    parse(response.body)
  end

  def post(body)
    response = conn.post(build_request[:command]) do |req|
      req.body = body
    end
    parse(response.body)

  end

  def parse(response_data)
    JSON.parse(response_data, symbolize_names: true)
  end

  def build_request(id = '')
    {
      single_series: "/api/series/#{id}",
      series:        '/api/series',
      episode_file:  "/api/episodefile?seriesId=#{id}",
      episode:       "/api/episode?seriesId=#{id}",
      command:       '/api/command'
    }
  end

  def build_post_body(series_id)
    { "name" => 'RescanSeries',
      "seriesId" => series_id
    }.to_json
  end
end
