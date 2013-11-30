class CollectionsPage < UnderOs::Page
  def initialize
    @collection = first('collection')
    @collection.number_of_items  = 1000
    @collection.on :item do |item, index|
      item.children[0].text = "##{index + 1}"
    end
  end
end
