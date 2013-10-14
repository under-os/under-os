describe UnderOs::UI::Style::Positioning do
  before do
    @view  = UnderOs::UI::View.new
    @style = @view.style
  end

  describe '#contentWidth' do
    before do
      @view = UnderOs::UI::Scroll.new
    end

    it "should allow to set the content sizes" do
      @view.style.contentWidth  = 100
      @view.style.contentHeight = 200

      @view.style.contentWidth.should  == 100
      @view.style.contentHeight.should == 200
    end
  end

  describe '#zIndex' do
    it "should return 0 by default" do
      @view.style.zIndex.should == 0
    end

    it "should allow to change it" do
      @view.style.zIndex = 100
      @view.style.zIndex.should == 100
    end
  end
end
