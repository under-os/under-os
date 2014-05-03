#
# The iOS level events receiver, not for a public use
#
class UnderOs::UI::Collection::Delegate < UIViewController

  def self.new(collection)
    alloc.tap do |instance|
      instance.instance_eval do
        @collection = collection
      end
    end
  end

  ################################################################
  # DataSource API
  ################################################################

  def numberOfSectionsInCollectionView(collection)
    @collection.number_of_sections
  end

  def collectionView(collection, numberOfItemsInSection: section)
    @collection.number_of_items(section)
  end

  def collectionView(collection, cellForItemAtIndexPath: indexPath)
    collection.dequeueReusableCellWithReuseIdentifier('UOSCollectionCell', forIndexPath:indexPath).tap do |item|
      @collection.emit(:item, item: item.uos_view_for(@collection), index: indexPath.row, section: indexPath.section)
    end
  end

  # def collectionView(collection, viewForSupplementaryElementOfKind: kind, atIndexPath: indexPath)
  #   # kind is a string
  #   UICollectionReusableView.alloc.init
    # UICollectionReusableView * reusableview = nil ;

    # if ( kind == UICollectionElementKindSectionHeader ) {
    #     RecipeCollectionHeaderView * headerView = [ collectionView dequeueReusableSupplementaryViewOfKind : UICollectionElementKindSectionHeader withReuseIdentifier : @ "HeaderView" forIndexPath : indexPath ] ;
    #     NSString * title = [ [ NSString alloc ] initWithFormat : @ "Recipe Group #%i" , indexPath.section + 1 ] ;
    #     headerView.title.text = title;
    #     UIImage * headerImage = [ UIImage imageNamed : @ "header_banner.png" ] ;
    #     headerView.backgroundImage.image = headerImage;

    #     reusableview = headerView;
    # }

    # if ( kind == UICollectionElementKindSectionFooter ) {
    #     UICollectionReusableView * footerview = [ collectionView dequeueReusableSupplementaryViewOfKind : UICollectionElementKindSectionFooter withReuseIdentifier : @ "FooterView" forIndexPath : indexPath ] ;

    #     reusableview = footerview;
    # }

    # return reusableview;
  # end


  ################################################################
  # DataSource API
  ################################################################

  def collectionView(collection, didSelectItemAtIndexPath: indexPath)
    if item = collection.cellForItemAtIndexPath(indexPath)
      @collection.emit(:select, item: item.uos_view_for(@collection), index: indexPath.row, section: indexPath.section)
    end
  end

  def collectionView(collection, didDeselectItemAtIndexPath: indexPath)
    if item = collection.cellForItemAtIndexPath(indexPath)
      @collection.emit(:unselect, item: item.uos_view_for(@collection), index: indexPath.row, section: indexPath.section)
    end
  end
end
