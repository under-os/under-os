describe UnderOs::UI::View do
  before do
    @view = UnderOs::UI::View.new
  end

  describe '#initialize' do
    it "should make UnderOs::UI::View instances" do
      @view.class.should == UnderOs::UI::View
    end

    it "should wrap an UIView instance" do
      @view._.class.should == UIView
    end

    it "should say its tag name is 'VIEW'" do
      @view.tagName.should == 'VIEW'
    end

    it "should allow build views with IDs" do
      view = UnderOs::UI::View.new(id: 'my-view')
      view.id.should == 'my-view'
    end

    it "should allow build views with class names" do
      view = UnderOs::UI::View.new(class: 'my-class another-class')
      view.className.should == 'my-class another-class'
    end

    it "should accept the 'data' option" do
      view = UnderOs::UI::View.new(data: {some: 'value'})
      view.data.should == {some: 'value'}
    end

    it "should accept the 'style' option" do
      view = UnderOs::UI::View.new(style: {width: 200})
      view.style.width.should == 200
    end
  end
end
