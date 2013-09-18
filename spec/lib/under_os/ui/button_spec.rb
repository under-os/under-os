describe UnderOs::UI::Button do
  it "should say its tag_name is 'BUTTON'" do
    UnderOs::UI::Button.new.tag_name.should == 'BUTTON'
  end
end
