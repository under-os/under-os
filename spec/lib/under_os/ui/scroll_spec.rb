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

    it "should accept the 'direction' option" do
      scroll = UnderOs::UI::Scroll.new(direction: 'x')
      scroll.direction.should == :x
    end

    it "should accept the 'indicator' option" do
      scroll = UnderOs::UI::Scroll.new(indicator: 'y')
      scroll.indicator.should == :y
    end

    it "should accept the 'bounces' option" do
      scroll = UnderOs::UI::Scroll.new(bounces: false)
      scroll.bounces.should == false
    end

    it "should accept the 'paging' option" do
      scroll = UnderOs::UI::Scroll.new(paging: true)
      scroll.paging.should == true
    end
  end

  describe '#direction' do
    it "should return :both by default" do
      @scroll.direction.should == :both
    end

    it "should accept the :x value" do
      @scroll.direction = 'x'
      @scroll.direction.should == :x
    end

    it "should accept the 'horizontal' value" do
      @scroll.direction = 'horizontal'
      @scroll.direction.should == :x
    end

    it "should accept the 'y' value" do
      @scroll.direction = 'y'
      @scroll.direction.should == :y
    end

    it "should accept the 'vertical' value" do
      @scroll.direction = 'vertical'
      @scroll.direction.should == :y
    end

    it "should accept the 'both' value" do
      @scroll.direction = 'both'
      @scroll.direction.should == :both
    end

    it "should fallback to the :both value" do
      @scroll.direction = 'weird stuff'
      @scroll.direction.should == :both
    end
  end

  describe '#indicator' do
    it "should return :both by default" do
      @scroll.indicator.should == :both
    end

    it "should accept the :x value" do
      @scroll.indicator = 'x'
      @scroll.indicator.should == :x
    end

    it "should accept the 'horizontal' value" do
      @scroll.indicator = 'horizontal'
      @scroll.indicator.should == :x
    end

    it "should accept the 'y' value" do
      @scroll.indicator = 'y'
      @scroll.indicator.should == :y
    end

    it "should accept the 'vertical' value" do
      @scroll.indicator = 'vertical'
      @scroll.indicator.should == :y
    end

    it "should accept the 'both' value" do
      @scroll.indicator = 'both'
      @scroll.indicator.should == :both
    end

    it "should accept the 'none' value" do
      @scroll.indicator = 'none'
      @scroll.indicator.should == :none
    end

    it "should fallback to the :both value" do
      @scroll.indicator = 'weird stuff'
      @scroll.indicator.should == :both
    end
  end

  describe '#bounces' do
    it "should return 'true' by default" do
      @scroll.bounces.should == true
    end

    it "should allow to switch it off" do
      @scroll.bounces = false
      @scroll.bounces.should == false
    end

    it "should fallback to true" do
      @scroll.bounces = 'weird stuff'
      @scroll.bounces.should == true
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
