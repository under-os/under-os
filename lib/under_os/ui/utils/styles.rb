#
# The styles handling API for UIView
#
module UnderOs::UI::Styles
  def style
    @style ||= UnderOs::UI::Style.new(@_)
  end

  def style=(hash)
    hash.each{ |key, value| style.__send__("#{key}=", value)}
  end

  def id
    @id
  end

  def id=(id)
    @id = id
  end

  def className
    (@classNames || []).join(' ')
  end

  def className=(names)
    @classNames = names.scan(/([a-z0-9\-_]+)/).map{|e| e[0]}
  end
end
