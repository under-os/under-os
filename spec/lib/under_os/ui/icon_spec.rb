describe UnderOs::UI::Icon do

  describe '#initialize' do
    it "should allow to initialize the icon with type" do
      icon = UnderOs::UI::Icon.new('ok')
      icon.type.should == 'ok'
    end

    it "should set the default size of 20 pixels" do
      icon = UnderOs::UI::Icon.new(type: 'ok')
      icon.size.should == 20
    end

    it "should assign correct tag name" do
      UnderOs::UI::Icon.new.tagName.should == 'ICON'
    end
  end

  describe '#type' do
    it "should compile types into acutal UTF-8 keys" do
      icon = UnderOs::UI::Icon.new(:ok)
      icon._.currentTitle.should == "\xEF\x80\x8C"
    end
  end

end
