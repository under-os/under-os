class CollectionsPage < UnderOs::Page
  def initialize
    @collection = first('collection')
    @collection.number_of_items  = 1000

    @collection.on :item do |event|
      event.item.removeClass 'selected' # recycle
      event.item.children[0].text = "##{event.index + 1}"
    end

    @collection.on :select do |event|
      event.item.addClass 'selected'
    end

    @collection.on :unselect do |event|
      event.item.removeClass 'selected'
    end
  end
end
