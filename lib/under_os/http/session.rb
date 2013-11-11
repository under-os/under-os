#
# Basically keeps track of cookies between the requests
#
class Session
  def initialize(default_options={})
    @options = default_options
    @options[:cookies] ||= {}
  end

  def cookies
    @options[:cookies]
  end

  def get(url, options={}, &block)
    request(url, {method: 'GET'}.merge(options), &block).send
  end

  def post(url, options={}, &block)
    request(url, {method: 'POST'}.merge(options), &block).send
  end

  def put(url, options={}, &block)
    request(url, {method: 'PUT'}.merge(options), &block).send
  end

  def delete(url, options={}, &block)
    request(url, {method: 'DELETE'}.merge(options), &block).send
  end

  def request(url, options={}, &block)
    options = options.merge(@options){|k,a,b| a.merge(b) }

    UnderOs::HTTP::Request.new(url, options, &block).tap do |request|
      request.on :response do |response|
        save_cookies response.headers["Set-Cookie"] || ''
      end
    end
  end

protected

  def save_cookies(cookies)
    cookies.scan(/([a-z_]+?)=([^; ]+)/).each do |key, value|
      unless ['path', 'domain', 'expires'].include?(key)
        @options[:cookies][key] = value
      end
    end
  end
end
