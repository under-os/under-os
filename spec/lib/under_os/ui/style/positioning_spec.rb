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

  describe 'scroller related styles' do
    before do
      @view = UnderOs::UI::Scroll.new
    end

    describe '#overflow' do
      it "accepts 'visible'" do
        @view.style.overflow = 'visible'
        @view.style.overflowX.should == :visible
        @view.style.overflowY.should == :visible
      end

      it "accepts 'hidden'" do
        @view.style.overflow = :hidden
        @view.style.overflowX.should == :hidden
        @view.style.overflowY.should == :hidden
      end

      it "accepts 'x'" do
        @view.style.overflow = 'x'
        @view.style.overflowX.should == :visible
        @view.style.overflowY.should == :hidden
      end

      it "accepts 'y'" do
        @view.style.overflow = 'y'
        @view.style.overflowX.should == :hidden
        @view.style.overflowY.should == :visible
      end

      it "falls back to 'visible'" do
        @view.style.overflow = 'weird stuff'
        @view.style.overflowX.should == :visible
        @view.style.overflowY.should == :visible
      end
    end
  end
end
