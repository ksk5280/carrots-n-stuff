class Drone
  def self.request_drone
    conn = Faraday.new(:url => 'http://162.243.248.192:9000') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    conn.post do |req|
      req.url '/actions'
      req.headers['Content-Type'] = 'application/json'
      req.body = '{"itemID":"1", "actions":["deploy"]}'
    end
  end
end
