class SidebarsPage < UnderOs::Page
  def initialize
    first('#top'   ).on(:tap){ show_on_top    }
    first('#left'  ).on(:tap){ show_on_left   }
    first('#right' ).on(:tap){ show_on_right  }
    first('#bottom').on(:tap){ show_on_bottom }

    @sidebar = first('sidebar#test')
  end

  def show_on_top
    return @sidebar.hide if @sidebar.visible?

    @sidebar.location = :top
    @sidebar.style.height = 100
    @sidebar.show
  end

  def show_on_left
    return @sidebar.hide if @sidebar.visible?

    @sidebar.location = :left
    @sidebar.style.width = 200
    @sidebar.show
  end

  def show_on_right
    return @sidebar.hide if @sidebar.visible?

    @sidebar.location = :right
    @sidebar.style.width = 200
    @sidebar.show
  end

  def show_on_bottom
    return @sidebar.hide if @sidebar.visible?

    @sidebar.location = :bottom
    @sidebar.style.height = 100
    @sidebar.show
  end
end
