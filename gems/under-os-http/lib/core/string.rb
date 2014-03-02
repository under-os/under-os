class String
  def url_encode(encoding=nil)
    stringByAddingPercentEscapesUsingEncoding ENCODINGS[encoding] || NSUTF8StringEncoding
  end

  def url_decode(encoding=nil)
    stringByReplacingPercentEscapesUsingEncoding ENCODINGS[encoding] || NSUTF8StringEncoding
  end
end
