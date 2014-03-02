describe "UnderOs::UI::Icon" do
  before do
    @icon = UnderOs::UI::Icon.new
  end

  describe '#initialize' do
    it "builds the UnderOs::UI::Icon instances" do
      @icon.class.should == UnderOs::UI::Icon
    end

    it "wraps an UIButton object" do
      @icon._.class.should == UIButton
    end

    it "should assign correct tag name" do
      @icon.tagName.should == 'ICON'
    end

    it "should allow to initialize the icon with type" do
      icon = UnderOs::UI::Icon.new('ok')
      icon.type.should == 'ok'
    end

    it "should set the default size of 20 pixels" do
      icon = UnderOs::UI::Icon.new(type: 'ok')
      icon.size.should == 20
    end
  end

  describe '#type' do
    it "should compile types into acutal UTF-8 keys" do
      icon = UnderOs::UI::Icon.new(:ok)
      icon._.currentTitle.should == "\xEF\x80\x8C"
    end
  end

  describe '#disabled' do
    it "returns 'false' by default" do
      @icon.disabled.should == false
    end

    it "reads the value right of the ios entity" do
      @icon._.enabled = false
      @icon.disabled.should == true
    end

    it "allows to disable the inputs" do
      @icon.disabled = true
      @icon._.isEnabled.should == false
    end

    it "has a ruby-style alias" do
      @icon.disabled?.should == false
    end
  end

end
