class CollectionsPage < UnderOs::Page
  def initialize
    @collection = first('collection')
    @collection.number_of_items  = 1000

    @collection.on :item do |item, index|
      item.text = "##{index + 1}"
      item.size = {x: 100, y: 30}
    end
  end

  class Thumb < Label

  end
end
