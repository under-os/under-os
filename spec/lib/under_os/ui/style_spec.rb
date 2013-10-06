describe UnderOs::UI::Style do
  before do
    @view  = UnderOs::UI::View.new
    @style = @view.style
  end

  it "should be an instance of UnderOs::UI::Style" do
    @style.class.should == UnderOs::UI::Style
  end

  it "should incapsulate the Element's raw uiview object" do
    @style.view.should === @view._
  end

  it "should always return the same object" do
    @view.style.should === @style
  end

end
