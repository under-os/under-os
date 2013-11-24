class UnderOs::UI::Collection::Item < UICollectionViewCell
  def self.classes
    @classes ||= {}
  end

  def initWithFrame(frame)
    super
  end

  def uos_view_for(collection)
    @uos_view ||= self.class.classes[collection].new.tap do |view|
      contentView.addSubview(view._)
    end
  end

  def prepareForReuse
    super
    @uos_view.cleanup if @uos_view && @uos_view.respond_to?(:cleanup)
  end
end
