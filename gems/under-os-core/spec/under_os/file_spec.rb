describe UnderOs::File do
  before do
    @existing_path = NSBundle.mainBundle.pathForResource("under-os.css", ofType:nil)
  end

  describe '.exists?' do
    it "returns true for existing files" do
      UnderOs::File.exists?(@existing_path).should == true
    end

    it "returns false for non existing files" do
      UnderOs::File.exists?("non-existing.file").should == false
    end
  end

  describe '.size' do
    it "returns file size" do
      UnderOs::File.size(@existing_path).should > 0
    end

    it "raises an error when exessing a non-existing file" do
      -> {
        UnderOs::File.size("non-existing.file")
      }.should.raise(StandardError)
    end
  end

  describe '.read' do
    it "reads files content" do
      content = UnderOs::File.read(@existing_path)
      content.class.should == String
      content.size.should > 0
    end

    it "raises an error when read a non-existing file" do
      -> {
        UnderOs::File.read("non-existing.file")
      }.should.raise(StandardError)
    end
  end

  describe '.write' do
    before do
      UnderOs::File.delete('test.txt')
      @result = UnderOs::File.write('test.txt', 'stuff')
    end

    it "creates new files" do
      UnderOs::File.exists?('test.txt').should == true
    end

    it "writes stuff into files" do
      UnderOs::File.read('test.txt').should == 'stuff'
    end

    it "overwrites existing files" do
      UnderOs::File.write('test.txt', 'new stuff')
      UnderOs::File.read('test.txt').should == 'new stuff'
    end

    it "returns a new File object" do
      @result.class.should == UnderOs::File
    end
  end

  describe '.size' do
    it "returns the file size" do
      UnderOs::File.write('test.txt', '12345')
      UnderOs::File.size('test.txt').should == 5
    end
  end

  describe '.delete' do
    before do
      UnderOs::File.write('test.txt', 'stuff')
    end

    it "deletes files" do
      UnderOs::File.delete('test.txt')
      UnderOs::File.exists?('test.txt').should == false
    end
  end

  describe '.tmp' do
    before do
      @file = UnderOs::File.tmp("test.txt")
    end

    it "creates a new File instance" do
      @file.class.should == UnderOs::File
    end

    it "should locate it in the tmp directory" do
      @file.path.to_s.should == "#{NSTemporaryDirectory()}test.txt"
    end
  end

end
