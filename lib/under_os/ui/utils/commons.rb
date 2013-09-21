module UnderOs::UI::Commons
  def tag_name
    @_tag_name ||= self.class.name.split('::').pop.underscore.upcase
  end

  def id
    @_id
  end

  def id=(id)
    @_id = id
  end

  def page
    @_page ||= parent && parent.page
  end

  def page=(page)
    @_page = page
  end
end
