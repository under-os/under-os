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

  def selected_item_class
    @selected_item_class
  end

  def selected_item_class=(css_class)
    @selected_item_class = css_class.to_s
    @selected_item_index = nil

    on :item do |event|
      if event.params[:index] == @selected_item_index
        event.params[:item].addClass @selected_item_class
      else
        event.params[:item].removeClass @selected_item_class
      end
    end

    on :select do |event|
      @selected_item_index = event.params[:index]
      event.params[:item].addClass @selected_item_class
    end

    on :unselect do |event|
      event.params[:item].removeClass @selected_item_class
    end
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
