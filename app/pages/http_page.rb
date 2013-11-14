class HttpPage < UnderOs::Page

  def initialize
    @search = first('#search-form input')
    @result = first('img#result')
    @locker = Locker.new

    first('#search-form button').on(:tap) { search }
  end

  def search
    @search.hide_keyboard
    @locker.show

    UnderOs::HTTP.get search_url do |response|
      UnderOs::HTTP.get parse_first_image_url(response.body) do |response|
        @result.src = UIImage.imageWithData(response.data)
        @locker.hide
      end
    end
  end

  def search_url
    query = @search.value
    query = 'puppy' if query.empty?

    "https://www.google.com.au/search?q=#{query}&source=lnms&tbm=isch"
  end

  def parse_first_image_url(html)
    html.scan(/imgurl=(http:\/\/[^&]+)/)[0][0]
  end

end
