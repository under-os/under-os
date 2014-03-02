#
# This thing catches styles from the collection element
# and adjusts the layout settings for them
#
class UnderOs::UI::Collection::Styles
  def self.build(collection, stylesheet)
    item = UnderOs::UI::Collection::Item.for(collection, stylesheet)

    collection.layout.item_size     = item.size
    collection.layout.items_spacing = item.style.marginLeft + item.style.marginRight
    collection.layout.rows_spacing  = item.style.marginTop  + item.style.marginBottom

    # TODO header/footer
  end
end
