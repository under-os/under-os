#
# The styles handling API for UIView
#
module UnderOs::UI::Styles
  def style(hash=nil)
    if hash
      self.style = hash
      self
    else
      @_style ||= UnderOs::UI::Style.new(self)
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
    repaint_if_classes_change do
      @_class_names = list.uniq.map(&:to_s)
    end
  end

  def hasClass(name)
    classNames.include?(name)
  end

  def addClass(name)
    repaint_if_classes_change do
      self.classNames += [name]
    end
  end

  def removeClass(name)
    repaint_if_classes_change do
      self.classNames -= [name]
    end
  end

  def toggleClass(name)
    if hasClass(name)
      removeClass name
    else
      addClass name
    end
  end

  def radioClass(name)
    parent.children.each do |view|
      view.removeClass(name) if view != self
    end

    addClass name
  end

  def repaint(stylesheet=nil)
    stylesheet ||= page && page.stylesheet
    stylesheet.apply_to(self) if stylesheet

    self
  end

private

  def repaint_if_classes_change
    prev_list = @_class_names.to_s
    yield if block_given?
    repaint if prev_list != @_class_names.to_s
    self
  end
end
