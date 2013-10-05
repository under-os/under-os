#
# The styles handling API for UIView
#
module UnderOs::UI::Styles
  def style(hash=nil)
    if hash
      self.style = hash
      self
    else
      @_style ||= UnderOs::UI::Style.new(@_)
    end
  end

  def style=(hash)
    hash.each{ |key, value| style.__send__("#{key}=", value)}
  end

  def className
    classNames.join(' ')
  end

  def className=(names)
    self.classNames = names.scan(/([a-z0-9\-_]+)/).map{|e| e[0]}
  end

  def classNames
    @_class_names ||= []
  end

  def classNames=(list)
    prev_list = @_class_names
    @_class_names = list.uniq

    repaint if prev_list != @_class_names
  end

  def repaint
    if page && page.stylesheet
      page.stylesheet.apply_to(self)
    end

    self
  end
end
