#
# A simple cookie jar thing
#
class UnderOs::HTTP::Cookies
  def initialize(cookies, url)
    @url  = url.is_a?(String) ? NSURL.URLWithString(url) : url
    @hash = cookies
  end

  def headers
    NSHTTPCookie.requestHeaderFieldsWithCookies(ios_cookies)
  end

  def to_s
    headers["Cookie"]
  end

protected

  def ios_cookies
    @hash.map do |key, value|
      NSHTTPCookie.cookieWithProperties({
        NSHTTPCookieDomain => @url.host,
        NSHTTPCookiePath   => "/",
        NSHTTPCookieName   => key.to_s,
        NSHTTPCookieValue  => value.to_s
      })
    end
  end
end
