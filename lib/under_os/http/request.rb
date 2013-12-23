#
# Options:
#
#   * :method   - GET, POST, ...
#   * :cookies  - Hash of cookie values
#   * :stream   - boolean, in case you want to stream stuff
#   * :params   - the POST/PUT/PATCH params hash
#   * :encoding - the POST data encoding
#
# Events:
#
#   * :response - when response header is received
#   * :data     - when a chunk of data is received
#   * :success  - when the request is successfully finished
#   * :failure  - when request has failed for whatever reason
#   * :complete - when it's complete (either way)
#
class UnderOs::HTTP::Request
  include UnderOs::Events

  attr_reader :url, :method, :params

  def initialize(url, options={}, &block)
    @url     = url
    @options = options

    on :complete, &block if block_given?
  end

  def on(*args, &block)
    super *args do |event|
      args = block.arity == 0 ? [] : [event.params[:response]]
      block.call *args
    end
  end

  def send
    @request    = build_request
    @receiver   = Receiver.new(self, @options[:stream])
    @connection = NSURLConnection.alloc.initWithRequest(@request, delegate:@receiver)
    @connection.start

    return self
  end

  def cancel
    @connection.cancel

    return self
  end

  def method
    method = @options[:method] || :get
    method = method.to_s.upcase
    method = 'GET' unless %w[GET POST PUT DELETE PATCH HEAD].include?(method)
    method
  end

  def headers
    @options[:headers] || {}
  end

  def cookies
    @options[:cookies] || {}
  end

  def params
    @options[:params] || {}
  end

  def encoding
    @options[:encoding] || 'utf-8'
  end

protected

  def build_request
    query = params.to_query

    url   = @url + (method != "GET" || query.empty? ? '' : (@url.include?('?') ? '&' : '?') + query)
    url   = NSURL.URLWithString(url)

    NSMutableURLRequest.requestWithURL(url).tap do |request|
      request.setHTTPMethod method

      headers.merge(UnderOs::HTTP::Cookies.new(cookies, url).headers).each do |key, value|
        request.addValue value, forHTTPHeaderField:key
      end

      if %w[POST PUT PATCH DELETE].include?(method) && !query.empty?
        request.addValue "application/x-www-form-urlencoded;charset=#{encoding}", forHTTPHeaderField:"Content-Type"
        request.setHTTPBody query.dataUsingEncoding(NSUTF8StringEncoding)
      end
    end
  end
end

