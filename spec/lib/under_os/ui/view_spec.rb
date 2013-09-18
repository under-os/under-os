describe UnderOs::UI::View do

  it "should say its tag name is 'VIEW'" do
    UnderOs::UI::View.new.tag_name.should == 'VIEW'
  end

  it "should allow build views with IDs" do
    view = UnderOs::UI::View.new(id: 'my-view')
    view.id.should == 'my-view'
  end

  it "should allow build views with class names" do
    view = UnderOs::UI::View.new(class: 'my-class another-class')
    view.class_name.should == 'my-class another-class'
  end
end
