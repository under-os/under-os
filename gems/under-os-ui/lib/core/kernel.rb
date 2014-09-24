module Kernel
  def u(css_rule)
    return UnderOs::App.history.current_page if css_rule == 'page'
    return UnderOs::App.history.navbar       if css_rule == 'navbar'

    UnderOs::App.history.current_page.find(css_rule)
  end
end
