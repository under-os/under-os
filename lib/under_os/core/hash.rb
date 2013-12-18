class Hash
  #
  # Converts a hash into an URL query string
  #
  def to_query(namespace=nil)
    map do |key, value|
      value.to_query(namespace ? "#{namespace}[#{key}]" : key)
    end.sort * '&'
  end
end
