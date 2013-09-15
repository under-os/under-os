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
end
