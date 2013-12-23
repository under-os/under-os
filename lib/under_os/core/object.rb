class Object
  def to_query(key)
    "#{key.to_s.url_encode}=#{to_s.url_encode}"
  end

  def to_json(pretty=nil)
    JSON.generate(self, pretty)
  end
end
