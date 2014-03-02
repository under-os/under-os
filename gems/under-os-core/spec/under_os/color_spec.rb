describe UnderOs::Color do
  def from(*args)
    UnderOs::Color.new(*args)
  end

  describe '#initialize' do
    it "should initialize from a UIColor" do
      color = from(UIColor.blueColor)
      color.ui.should == UIColor.blueColor
    end

    it "should always return the same instance" do
      color1 = from(UIColor.blackColor)
      color2 = from(UIColor.blackColor)

      color1.should === color2
    end

    it "should work with rgba arrays of integers" do
      from(0, 0, 255, 1.0).should == UIColor.blueColor
    end

    it "should work with rgba arrays of floats" do
      from(0.0, 0.0, 1.0, 1.0).should == UIColor.blueColor
    end

    it "should work with rgb arrays of integers" do
      from(0, 0, 255).should == UIColor.blueColor
    end

    it "should work with rgb arrays of floats" do
      from(0.0, 0.0, 1.0).should == UIColor.blueColor
    end

    it "should work with string color names" do
      from('blue').should == UIColor.blueColor
    end

    it "should work with symbol color names" do
      from(:blue).should == UIColor.blueColor
    end

    it "should work with string hex colors" do
      from('#ff8000').should == UIColor.orangeColor
    end

    it "should work with short hand colors" do
      from('#ff0').should == UIColor.yellowColor
    end

    it "should work with rgb() strings" do
      from('rgb(10, 20, 30)').to_rgba.should == [10, 20, 30, 1.0]
    end

    it "should work with rgba() strings" do
      from('rgba(100, 200, 250, 0.5)').to_rgba.should == [100, 200, 250, 0.5]
    end

    it 'should work with flaot color circle params' do
      from(0.23).to_s.should == '#9eff00'
    end

    it 'should work with integer (in degrees) color circle params' do
      from(23).to_s.should == '#9eff00'
    end
  end

  describe '#to_rgba' do
    it "should extract the data correctly" do
      from(UIColor.blueColor).to_rgba.should == [0, 0, 255, 1.0]
    end
  end

  describe '#to_rgb' do
    it "should extract the data correctly" do
      from(UIColor.yellowColor).to_rgb.should == [255, 255, 0]
    end
  end

  describe '#to_hex' do
    it "should extract the data correctly" do
      from(UIColor.orangeColor).to_hex.should == '#ff8000'
    end
  end

  describe '#to_s' do
    it "should extract the data correctly" do
      from(UIColor.brownColor).to_s.should == '#996633'
    end
  end

  describe '#==' do
    it "should work with other colors" do
      from(UIColor.blueColor).should     == from(UIColor.blueColor)
      from(UIColor.blueColor).should.not == from(UIColor.orangeColor)
    end

    it "should work with UIColors" do
      from(UIColor.blueColor).should     == UIColor.blueColor
      from(UIColor.blueColor).should.not == UIColor.orangeColor
    end

    it "should work with RGB arrays" do
      from(UIColor.blueColor).should     == [0, 0, 255]
      from(UIColor.blueColor).should.not == [0, 255, 0]
    end

    it "should work with RGBA arrays" do
      from(UIColor.blueColor).should     == [0, 0, 255, 1.0]
      from(UIColor.blueColor).should.not == [0, 255, 0, 1.0]
    end

    it "should work with string names" do
      from(UIColor.blueColor).should     == 'blue'
      from(UIColor.blueColor).should.not == 'orange'
    end

    it "should work with symbol names" do
      from(UIColor.blueColor).should     == :blue
      from(UIColor.blueColor).should.not == :orange
    end

    it "should work with hex values" do
      from(UIColor.blueColor).should     == '#0000ff'
      from(UIColor.blueColor).should.not == '#00ff00'
    end

    it "should work with short hex values" do
      from(UIColor.blueColor).should     == '#00f'
      from(UIColor.blueColor).should.not == '#0f0'
    end
  end
end
