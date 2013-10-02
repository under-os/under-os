module UnderOs::UI::Commons
  def id
    @_id
  end

  def id=(id)
    @_id = id
  end

  def tagName
    @_tag_name ||= UnderOs::UI::Wrap::WRAPS_TAGS_MAP.detect{|t,k| k == self.class}[0].upcase
  end

  def data
    @_data
  end

  def data=(hash)
    @_data = hash
  end
end
