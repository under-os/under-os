class UnderOs::UI::Collection::Styles
  def self.build(collection, stylesheet)
    @heads_receiver ||= Receiver.new(collection, 'HEADER')
    @foots_receiver ||= Receiver.new(collection, 'FOOTER')

    item_styles = stylesheet.styles_for(items_receiver(collection))
    UnderOs::UI::Collection::Item.styles[collection] = item_styles
    collection.layout.item_size = {x: item_styles[:width], y: item_styles[:height]} # TODO figure something smarter

    # p stylesheet.styles_for(@heads_receiver)
    # p stylesheet.styles_for(@foots_receiver)
  end

  def self.items_receiver(collection)
    @items_receiver ||= Receiver.new(collection, 'ITEM')
  end

  class Receiver
    attr_reader :parent, :tagName, :id, :classNames

    def initialize(collection, tag_name)
      @parent     = collection
      @tagName    = tag_name
      @id         = nil
      @classNames = []
    end
  end
end
