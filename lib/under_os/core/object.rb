class Object
  def to_query(key)
    "#{key.to_s.url_encode}=#{to_s.url_encode}"
  end
end
