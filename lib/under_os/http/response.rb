class UnderOs::HTTP::Response
  attr_reader :data

  def initialize(data, response)
    @data     = data
    @response = response
  end

  def headers
    @response.allHeaderFields
  end

  def body
    @body ||= @data.to_s
  end

  def image
    @image ||= UIImage.imageWithData(@data)
  end
end
