describe UnderOs::UI::Icon do

  describe '#initialize' do
    it "should allow to initialize the icon with name" do
      icon = UnderOs::UI::Icon.new('ok')
      icon.name.should == 'ok'
    end

    it "should set the default size of 20 pixels" do
      icon = UnderOs::UI::Icon.new(name: 'ok')
      icon.size.should == 20
    end

    it "should set default color to 'black'" do
      icon = UnderOs::UI::Icon.new(:ok)
      icon.style.color.should == UIColor.blackColor
    end
  end

  describe '#name' do
    it "should compile names into acutal UTF-8 keys" do
      icon = UnderOs::UI::Icon.new(:ok)
      icon._.currentTitle.should == "\xEF\x80\x8C"
    end
  end

end
