class UnderOs::UI::Collection::Delegate
  def initialize(collection)
    @collection = collection
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
    collection.dequeueReusableCellWithReuseIdentifier('CollectionItem', forIndexPath:indexPath).tap do |item|
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
    @collection.emit(:select, index: indexPath.row, section: indexPath.section)
  end

  def collectionView(collection, didDeselectItemAtIndexPath: indexPath)
    @collection.emit(:unselect, index: indexPath.row, section: indexPath.section)
  end
end
