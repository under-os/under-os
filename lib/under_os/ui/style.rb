#
# The view styles handling wrapper
#
# The idea here is to provide a DOM like `style` object,
# which can take similar to DOM properties and translate
# them into iOS equivalents
#
class UnderOs::UI::Style
  include Fonts
  include Margins
  include Outlining
  include Positioning

  attr_reader :view

  def initialize(view)
    @view = view
  end

end
