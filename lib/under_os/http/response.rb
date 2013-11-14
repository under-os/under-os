class UnderOs::HTTP::Response
  attr_reader :data

  def initialize(response, data)
    @response = response
    @data     = data # raw NSData
  end

  def headers
    @response.allHeaderFields
  end

  def body
    @body ||= @data.to_s
  end

  def content_length
    headers["Content-Length"].to_i
  end

  def content_type
    headers["Content-Type"]
  end
end
