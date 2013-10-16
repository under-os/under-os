module Kernel
  def u(css_rule)
    page = UnderOs::App.navigation.current_page
    elements = page.find(css_rule)

    if elements.size == 0
      nil
    elsif elements.size == 1
      elements[0]
    else
      elements
    end
  end
end
