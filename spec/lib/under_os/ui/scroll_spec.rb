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
end
