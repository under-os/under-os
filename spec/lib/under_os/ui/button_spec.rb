describe UnderOs::UI::Button do
  it "should say its tagName is 'BUTTON'" do
    UnderOs::UI::Button.new.tagName.should == 'BUTTON'
  end
end
