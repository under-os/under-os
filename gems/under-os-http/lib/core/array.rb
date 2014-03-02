class Array
  def to_query(key)
    collect { |value| value.to_query("#{key}[]") }.join '&'
  end
end
