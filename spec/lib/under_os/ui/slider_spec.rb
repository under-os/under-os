describe UnderOs::UI::Slider do
  before do
    @slider = UnderOs::UI::Slider.new
  end

  describe '#initialize' do
    it "should spawn new sliders" do
      @slider.class.should == UnderOs::UI::Slider
    end

    it "should wrap the UISlider class" do
      @slider._.class.should == UISlider
    end

    it "should assign correct tag name" do
      @slider.tagName.should == 'SLIDER'
    end

    it "should accept the 'value' option" do
      slider = UnderOs::UI::Slider.new(value: 0.4)
      slider.value.should == 0.4
    end

    it "should accept the 'min' option" do
      slider = UnderOs::UI::Slider.new(min: 4)
      slider.min.should == 4
    end

    it "should accept the 'max' option" do
      slider = UnderOs::UI::Slider.new(max: 4)
      slider.max.should == 4
    end
  end

  describe '#value' do
    it "should assign the value property correctly" do
      @slider.value = 0.25
      @slider._.value.should == 0.25
    end
  end

  describe '#min' do
    it "should assign the minimal value boundaries correctly" do
      @slider.min = -10
      @slider._.minimumValue.should == -10
    end

    it "should return the minimum value as it is" do
      @slider.min = -20
      @slider.min.should == -20
    end
  end

  describe '#max' do
    it "should assign the maximal value boundaries correctly" do
      @slider.max = -10
      @slider._.maximumValue.should == -10
    end

    it "should return the maximum value as it is" do
      @slider.max = -20
      @slider.max.should == -20
    end
  end
end
