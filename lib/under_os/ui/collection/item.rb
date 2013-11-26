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

      # spoofing the #parent reference to use the item styles receiver as a reference
      def view.parent; @_parent; end
      view.instance_variable_set('@_parent', UnderOs::UI::Collection::Styles.items_receiver(collection))

      # repainting the item using the current stylesheet
      view.repaint(UnderOs::App.history.current_page.stylesheet)
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
