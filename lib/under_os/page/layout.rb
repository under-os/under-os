class UnderOs::Page::Layout

  def initialize(page)
    @page = page

    build_layout_from_xib || build_layout_from_html

    @page.view = UnderOs::UI::View.new(@page._.view)
    @page.view.instance_variable_set('@_tag_name', 'PAGE')
  end

  def build_layout_from_xib
    filename = @page.class.layout || "#{@page.name}.xib"
    filename, type = filename.match(/^(.+?)\.([a-z]+)$/).to_a.slice(1,2)

    if type == 'xib' && NSBundle.mainBundle.pathForResource(filename, ofType:type)
      @page._.view = NSBundle.mainBundle.loadNibNamed(filename, owner:self, options:nil)[0]
    end
  end

  def build_layout_from_html
    # if layout = UnderOs::Parser.parse("#{@page.name}.html")
      @page._.view = UIView.alloc.initWithFrame([[0,0], [0, 0]])
    # end
  end

end
