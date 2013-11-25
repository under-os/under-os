class UnderOs::UI::Collection < UnderOs::UI::View
  wraps UICollectionView, tag: :collection

  def initialize(options={})
    super

    self.layout = Layout.new                          if ! options[:layout]
    self.layout = options.delete(:layout)             if options[:layout].is_a?(Class)
    self.layout = options.delete(:layout).constantize if options[:layout].is_a?(String)
    self.item   = options.delete(:item)               if options[:item].is_a?(Class)
    self.item   = options.delete(:item).constantize   if options[:item].is_a?(String)

    @_.dataSource = @_.delegate = @delegate = Delegate.new(self) # isolating the context
  end

  def on(*args, &block)
    super *args do |event|
      params = [event.item, event.index, event.section].compact
      params = params.slice(0, block.arity) if block.arity > -1

      block.call *params
    end
  end

  def layout
    @layout
  end

  def layout=(layout)
    layout = Layout.new(layout) if layout.is_a?(UICollectionViewLayout)
    @_.collectionViewLayout = (@layout = layout)._
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

  def repaint(stylesheet=nil)
    stylesheet ||= page && page.stylesheet

    self.style = stylesheet.styles_for(self) if stylesheet
    Styles.build(self, stylesheet)           if stylesheet
  end
end
