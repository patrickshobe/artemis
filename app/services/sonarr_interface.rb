class SonarrInterface

	def conn
    Faraday.new(:url => ENV['SONARR_ROUTE'] ) do |f|
      f.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      f.headers['X-Api-Key'] = ENV['SONARR_API_KEY']
    end
  end

  def get_all_series
    JSON.parse(conn.get('/api/series').body)
  end
end
