class UnderOs::UI::Scroll < UnderOs::UI::View
  wraps UIScrollView, tag: :scroll

  def initialize(options={})
    super

    self.paging = options.delete(:paging)
  end

  def paging
    @paging == nil ? false : @paging
  end

  def paging=(value)
    @paging = value == true ? true : nil
    @_.pagingEnabled = paging
  end

  def contentSize
    UnderOs::Point.new(x: @_.contentSize.width, y: @_.contentSize.height)
  end

  def contentSize=(*args)
    size = UnderOs::Point.new(*args)
    @_.contentSize = CGSizeMake(size.x, size.y)
  end

  def repaint(*args)
    content_size = {}

    super *args do |styles|
      styles.reject do |key, value|
        if [:contentWidth, :contentHeight].include?(key)
          content_size[key] = value
        end
      end
    end

    self.style = content_size unless content_size.empty?
  end
end
