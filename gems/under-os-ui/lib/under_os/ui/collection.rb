class UnderOs::UI::Collection < UnderOs::UI::View
  wraps UICollectionView, tag: :collection

  def initialize(options={})
    super

    self.layout = Layout.new                          if ! options[:layout]
    self.layout = options.delete(:layout)             if options[:layout].is_a?(Class)
    self.layout = options.delete(:layout).constantize if options[:layout].is_a?(String)

    @_.delegate = @_.dataSource = Delegate.new(self)
    @_.registerClass(Cell, forCellWithReuseIdentifier:'UOSCollectionCell')
  end

  def on(*args, &block)
    super *args do |event|
      params = [event.item, event.index, event.section]
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

  def item_class
    Cell.classes[self]
  end

  def item_class=(klass)
    Cell.classes[self] = klass
  end

  def reload
    @_.reloadData
    self
  end

  def number_of_items(section=0)
    (@number_of_items || [0])[section]
  end

  def number_of_items=(value)
    @number_of_items = value.is_a?(Numeric) ? [value] : value
    reload
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
