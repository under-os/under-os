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
      if image_url = parse_first_image_url(response)
        @result.load image_url do
          @locker.hide
        end
      else
        @locker.hide
      end
    end
  end

  def search_url
    query = @search.value
    query = 'puppy' if query.empty?
    query = String.new(query).url_encode

    "https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=#{query}"
  end

  def parse_first_image_url(response)
    response.json["responseData"]["results"][0]["url"] rescue nil # ftw!
  end

end
