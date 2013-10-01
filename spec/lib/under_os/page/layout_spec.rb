describe UnderOs::Page::Layout do
  before do
    @page   = TestPage.new
    @layout = UnderOs::Page::Layout.new(@page)
  end

  it "should pickup the elements from the layout.html file" do
    @page.view.should.not == nil
    children = @page.view.children
    children.size.should == 1
    children[0].class.should == UnderOs::UI::Button
    children[0].text.should  == 'Say Hello'
  end

  it "should pickup the page title from the test layout" do
    @page.title.should == 'Hello World'
  end
end
