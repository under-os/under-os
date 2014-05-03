class CollectionsPage < UnderOs::Page
  def initialize
    @collection = first('collection')
    @collection.number_of_items  = 1000
    @collection.selected_item_class = :selected

    @collection.on :item do |event|
      event.item.children[0].text = "##{event.index + 1}"
    end
  end
end
