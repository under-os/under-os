describe UnderOs::UI::Switch do
  before do
    @switch = UnderOs::UI::Switch.new
  end

  it "inherits fromthe UnderOs::UI::Input" do
    (UnderOs::UI::Switch < UnderOs::UI::Input).should == true
  end

  describe '#initialize' do
    it "should spawn new switchs" do
      @switch.class.should == UnderOs::UI::Switch
    end

    it "should wrap the UISwitch class" do
      @switch._.class.should == UISwitch
    end

    it "should assign correct tag name" do
      @switch.tagName.should == 'SWITCH'
    end

    it "should accept the 'value' option" do
      switch = UnderOs::UI::Switch.new(value: 'smth')
      switch.value.should == 'smth'
    end

    it "should accept the 'checked' option" do
      switch = UnderOs::UI::Switch.new(checked: true)
      switch.checked.should == true
    end
  end

  describe '#value' do
    it "should save the value correctly" do
      @switch.value = 'something'
      @switch.value.should == 'something'
    end
  end

  describe '#checked' do
    it "should allow to flip the switch on" do
      @switch.checked = true
      @switch._.on?.should == true
    end

    it "should allow to flip the switch off" do
      @switch.checked = false
      @switch._.on?.should == false
    end

    it "should return the state back correctly" do
      @switch.checked = true
      @switch.checked.should == true

      @switch.checked = false
      @switch.checked.should == false
    end
  end
end
