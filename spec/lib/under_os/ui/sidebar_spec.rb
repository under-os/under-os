describe UnderOs::UI::Sidebar do
  before do
    @sidebar = UnderOs::UI::Sidebar.new
  end

  describe '#initialize' do
    it "should build sidebars" do
      @sidebar.class.should == UnderOs::UI::Sidebar
    end

    it "should wrap up a normal UIView" do
      @sidebar._.class.should == UIView
    end

    it "should have the 'SIDEBAR' tag" do
      @sidebar.tagName.should == "SIDEBAR"
    end

    it "should accept the 'location' option" do
      sidebar = UnderOs::UI::Sidebar.new(location: :left)
      sidebar.location.should == :left
    end

    it "should accept the 'animated' option" do
      sidebar = UnderOs::UI::Sidebar.new(animated: false)
      sidebar.animated.should == false
    end
  end

  describe '#location' do
    it "should return :bottom by default" do
      @sidebar.location.should == :bottom
    end

    it "should accept other values" do
      @sidebar.location = 'top'
      @sidebar.location.should == :top
    end
  end

  describe '#animated' do
    it "should return `true` by default" do
      @sidebar.animated.should == true
    end

    it "should allow to set it to false" do
      @sidebar.animated = false
      @sidebar.animated.should == false
    end
  end
end
