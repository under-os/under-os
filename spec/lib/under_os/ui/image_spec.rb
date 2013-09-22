describe UnderOs::UI::Image do

  describe '#initialize' do
    before do
      @image = UnderOs::UI::Image.new(src: 'test.png')
    end

    it "should say it has the 'IMG' tag name" do
      @image.tagName.should == 'IMG'
    end

    it "should extract and assign the image source" do
      @image._.image.class.should == UIImage
    end
  end


  describe '#src' do
    before do
      @image = UnderOs::UI::Image.new
    end

    it "should be nil" do
      @image.src.should == nil
    end

    it "should allow to specify the source as a file name" do
      @image.src = 'test.png'
      @image.src.class.should == UIImage
    end

    it "should allow to specify the source as an UIImage object" do
      src = UIImage.imageNamed('test.png')
      @image.src = src
      @image.src.should == src
    end
  end

end
