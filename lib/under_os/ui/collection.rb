class UnderOs::UI::Collection < UnderOs::UI::View
  wraps UICollectionView, tag: :collection

  def initialize(options={})
    super

    self.layout = options.delete(:layout) || Layout.new
    self.item   = options.delete(:item)   if options[:item].is_a?(Class)
    self.item   = options.delete(:item).constantize if options[:item].is_a?(String)

    @_.dataSource = @_.delegate = @delegate = Delegate.new(self) # isolating the context
  end

  def on(*args, &block)
    super *args do |event|
      params = []
      params << event.item    if block.arity != 0
      params << event.index   if block.arity > 1 || block.arity < 0
      params << event.section if block.arity > 2 || block.arity < 0

      block.call *params
    end
  end

  def layout
    @layout ||= Layout.new(@_.collectionViewLayout)
  end

  def layout=(layout)
    layout = Layout.new(layout) if layout.is_a?(UICollectionViewLayout)
    @layout = layout
    @_.collectionViewLayout = layout._
  end

  def item
    Item.classes[self]
  end

  def item=(item_class)
    Item.classes[self] = item_class
    @_.registerClass(Item, forCellWithReuseIdentifier:'CollectionItem')
  end

  def reload
    @_.reloadData
  end

  def number_of_items(section=0)
    (@number_of_items || [0])[section]
  end

  def number_of_items=(value)
    @number_of_items = value.is_a?(Numeric) ? [value] : value
  end

  def number_of_sections
    (@number_of_items || [0]).size
  end

end
