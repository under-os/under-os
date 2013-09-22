#
# The styles handling API for UIView
#
module UnderOs::UI::Styles
  def style
    @_style ||= UnderOs::UI::Style.new(@_)
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
    @_class_names = list.uniq
  end
end
