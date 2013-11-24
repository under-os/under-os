module Kernel
  def u(css_rule)
    return UnderOs::App.history.current_page if css_rule == 'page'
    return UnderOs::App.history.navbar       if css_rule == 'navbar'

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
