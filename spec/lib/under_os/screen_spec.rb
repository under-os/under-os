describe UnderOs::Screen do

  describe '#size' do
    it "should return the size as a Point" do
      size = UnderOs::Screen.size
      size.class.should == UnderOs::Point

      p size
    end
  end
end
