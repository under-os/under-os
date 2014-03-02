describe UnderOs::UI::Collection do
  describe '#initialize' do
    before do
      @collection = UnderOs::UI::Collection.new
    end

    it "makes instances of UI::Collection" do
      @collection.class.should == UnderOs::UI::Collection
    end

    it "wraps the UICollectionView object" do
      @collection._.class.should == UICollectionView
    end

    it "assigns the COLLECTION class" do
      @collection.tagName.should == "COLLECTION"
    end
  end
end
