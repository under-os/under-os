class UnderOs::UI::Collection::Styles
  def self.build(collection, stylesheet)
    @items_receiver ||= Receiver.new(collection, 'ITEM')
    @heads_receiver ||= Receiver.new(collection, 'HEADER')
    @foots_receiver ||= Receiver.new(collection, 'FOOTER')

    item_styles = stylesheet.styles_for(@items_receiver)
    UnderOs::UI::Collection::Item.styles[collection] = item_styles
    collection.layout.item_size = {x: item_styles[:width], y: item_styles[:height]} # TODO figure something smarter

    # p stylesheet.styles_for(@heads_receiver)
    # p stylesheet.styles_for(@foots_receiver)
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
