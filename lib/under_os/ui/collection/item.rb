#
# This is the collection item class that you supposed
# to inherit (well, if you need to)
#
class UnderOs::UI::Collection::Item < UnderOs::UI::View

  tag :item

  def self.build(collection, &builder)
    @builders           ||= {}
    @builders[collection] = builder
    collection.item_class = self
  end

  def self.for(collection, stylesheet=nil)
    new.tap do |view|
      def view.parent; @_parent; end
      view.instance_variable_set('@_parent', collection)

      @builders[collection] && @builders[collection].call.each do |child|
        view.insert child
      end

      view.repaint(stylesheet || UnderOs::App.history.current_page.stylesheet)
    end
  end

  def cleanup
    # implement me if you need to clean cells between reuse
  end

end
