class UnderOs::UI::Collection::Item < UICollectionViewCell
  def self.classes
    @classes ||= {}
  end

  def self.styles
    @styles ||= {}
  end

  def uos_view_for(collection)
    paint_for(collection)

    @uos_view ||= self.class.classes[collection].new.tap do |view|
      contentView.addSubview(view._)
    end
  end

  def paint_for(collection)
    if ! @style
      @style = UnderOs::UI::Style.new(self, :item)
      (self.class.styles[collection] || {}).each do |key, value|
        @style.__send__ "#{key}=", value
      end
    end
  end

  def prepareForReuse
    super
    @uos_view.cleanup if @uos_view && @uos_view.respond_to?(:cleanup)
  end
end
