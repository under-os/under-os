class UnderOs::Page::Layout

  def initialize(page)
    @page = page

    build_layout_from_xib || build_layout_from_html || build_layout_from_nothing

    @page.view = UnderOs::UI::View.new(@page._.view)
    @page.view.instance_variable_set('@_tag_name', 'PAGE')
  end

  def build_layout_from_xib
    if filename = find_layout_with_type('xib')
      @page._.view = NSBundle.mainBundle.loadNibNamed(filename.sub(/\.xib$/, ''), owner:self, options:nil)[0]
    end
  end

  def build_layout_from_html
    if filename = find_layout_with_type('html')
      if layout = UnderOs::Parser.parse(filename)
        if view = UnderOs::Page::Builder.views_from(layout)[0]
          @page._.view = view._
          @page.title  = layout[0][:attrs][:title] || ''
        end
      end
    end
  end

  def build_layout_from_nothing
    @page._.view = UIView.alloc.init
    @page._.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
  end

  def find_layout_with_type(ext)
    filename = @page.class.layout || "#{@page.name}.#{ext}"
    filename, type = filename.match(/^(.+?)\.([a-z]+)$/).to_a.slice(1,2)

    if type == ext && NSBundle.mainBundle.pathForResource(filename, ofType:type)
      "#{filename}.#{type}"
    end
  end

end
