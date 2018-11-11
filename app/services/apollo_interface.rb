class ApolloInterface

  def initialize(apollo_path)
    @apollo_path = apollo_path
  end

	def conn
    Faraday.new(:url => @apollo_path  ) do |f|
      f.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def post(body)
    conn.post('/api/v1/encodes') do |req|
      req.body = body
    end
  end

  def parse(response_data)
    JSON.parse(response_data, symbolize_names: true)
  end

  def self.quick_post( path, body )
    apollo = new(path)
    apollo.post( body )
  end
end
