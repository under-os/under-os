class UnderOs::UI::Scroll < UnderOs::UI::View
  wraps UIScrollView, tag: :scroll

  def initialize(options={})
    super

    self.paging = options.delete(:paging)

    @_.delegate = self
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

  def centerContent
    left = @_.contentSize.width > @_.bounds.size.width ? 0 :
      (@_.bounds.size.width - @_.contentSize.width) * 0.5

    top  = @_.contentSize.height > @_.bounds.size.height ? 0 :
      (@_.bounds.size.height - @_.contentSize.height) * 0.5

    @_.contentInset = UIEdgeInsetsMake(top, left, top, left)
  end

  def scale
    @_.zoomScale
  end

  def scale=(scale)
    @_.zoomScale = scale
  end

  def minScale
    @_.minimumZoomScale
  end

  def minScale=(scale)
    @_.minimumZoomScale = scale
  end

  def maxScale
    @_.maximumZoomScale
  end

  def maxScale=(scale)
    @_.maximumZoomScale = scale
  end

  def zoomItem
    @zoomItem
  end

  def zoomItem=(item)
    @zoomItem   = item.is_a?(UnderOs::UI::View) ? item._ : item
  end

  def viewForZoomingInScrollView(scrollView)
    @zoomItem
  end

  def scrollViewDidZoom(scrollView)
    emit :zoom
  end
end
