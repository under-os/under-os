module UnderOs::UI::Commons
  def id
    @_id
  end

  def id=(id)
    @_id = id
  end

  def tagName
    @_tag_name ||= self.class.name.split('::').pop.underscore.upcase
  end
end
