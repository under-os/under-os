describe "UnderOs::UI::Div" do
  before do
    @div = UnderOs::UI::Div.new
  end

  describe "constructor" do
    it "builds an UnderOs::UI::Div instance" do
      @div.class.should == UnderOs::UI::Div
    end

    it "wraps a generic UIView element" do
      @div._.class.should == UIView
    end

    it "has the DIV tag assigned to the element" do
      @div.tagName.should == "DIV"
    end

    it "handles the usual options" do
      div = UnderOs::UI::Div.new(id: 'my-div')
      div.id.should == 'my-div'
    end
  end
end
