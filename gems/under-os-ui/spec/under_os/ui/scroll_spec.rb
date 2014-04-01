describe UnderOs::UI::Scroll do
  before do
    @scroll = UnderOs::UI::Scroll.new
  end

  describe '#initialize' do
    it 'should build an UI:Scroll object' do
      @scroll.class.should == UnderOs::UI::Scroll
    end

    it "should wrap an UIScrollView instance" do
      @scroll._.class.should == UIScrollView
    end

    it "should have the SCROLL tag" do
      @scroll.tagName.should == 'SCROLL'
    end

    it "should accept the 'paging' option" do
      scroll = UnderOs::UI::Scroll.new(paging: true)
      scroll.paging.should == true
    end
  end

  describe '#paging' do
    it "should return 'false' by default" do
      @scroll.paging.should == false
    end

    it "should to switch it on" do
      @scroll.paging = true
      @scroll.paging.should == true
    end

    it "should fallback to false" do
      @scroll.paging = 'weird stuff'
      @scroll.paging.should == false
    end
  end

  describe "#scale" do
    it "should allow to read it" do
      @scroll.scale.should == 1.0
    end

    it "should allow to set it" do
      @scroll.scale = 2.4
      @scroll._.zoomScale.should == 1.0 # it will fall back to it
    end
  end

  describe "#minScale" do
    it "should allow to read it" do
      @scroll._.minimumZoomScale = 1.8
      @scroll.minScale.should == 1.8
    end

    it "should allow to set it" do
      @scroll.minScale = 2.7
      @scroll._.minimumZoomScale.should == 2.7
    end
  end

  describe "#maxScale" do
    it "should allow to read it" do
      @scroll._.maximumZoomScale = 1.8
      @scroll.maxScale.should == 1.8
    end

    it "should allow to set it" do
      @scroll.maxScale = 2.7
      @scroll._.maximumZoomScale.should == 2.7
    end
  end
end
