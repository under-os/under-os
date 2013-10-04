describe UnderOs::Screen do

  describe '#size' do
    it "should return the size as a Point" do
      size = UnderOs::Screen.size
      size.class.should == UnderOs::Point
      size.x.should == 320
      size.y.should == 568
    end
  end
end
