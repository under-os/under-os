describe UnderOs::UI::Spinner do
  before do
    @spinner = UnderOs::UI::Spinner.new
  end

  it "should build a spinner" do
    @spinner.class.should == UnderOs::UI::Spinner
  end

  it "should wrap the UIActivityIndicatorView" do
    @spinner._.class.should == UIActivityIndicatorView
  end

  it "should have the correct tag name" do
    @spinner.tagName.should == 'SPINNER'
  end
end
