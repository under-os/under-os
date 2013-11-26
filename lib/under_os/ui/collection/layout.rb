class Layout
  attr_reader :_

  def initialize(layout=nil)
    @_ = layout || UICollectionViewFlowLayout.alloc.init

    self.items_spacing = 0
    self.rows_spacing  = 1
  end

  def item_size
  end

  def item_size=(*size)
    size = UnderOs::Point.new(*size)
    @_.itemSize = CGSizeMake(size.x, size.y)
  end

  def items_spacing
    @_.minimumInteritemSpacing
  end

  def items_spacing=(value)
    @_.minimumInteritemSpacing = value
  end

  def rows_spacing
    @_.minimumLineSpacing
  end

  def rows_spacing=(value)
    @_.minimumLineSpacing = value
  end

  def section_inset
  end

  def section_inset=(value)
  end
end
