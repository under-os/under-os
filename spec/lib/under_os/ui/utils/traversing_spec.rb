describe UnderOs::UI::Traversing do

  before do
    @v1 = UnderOs::UI::View.new
    @v2 = UnderOs::UI::View.new
  end

  describe '#parent' do
    it "should be nil by default" do
      @v1.parent.should == nil
      @v2.parent.should == nil
    end

    it "should return the correct view if the parent is set" do
      @v1.insert(@v2)
      @v2.parent.should == @v1
    end
  end

  describe '#children' do
    it "should return an empty array by default" do
      @v1.children.should == []
      @v2.children.should == []
    end

    it "should return the list of children when there are some" do
      @v1.insert(@v2)
      @v1.children.should == [@v2]
    end
  end

end
