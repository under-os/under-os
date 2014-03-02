describe String do
  describe '#underscore' do
    it "converts camelized strings into underscored" do
      "SomeStuff".underscore.should == 'some_stuff'
    end

    it "converts dashed strings into underscored as well" do
      "some-stuff".underscore.should == "some_stuff"
    end
  end

  describe "#camelize" do
    it "converts underscored strings into camelized" do
      "some_stuff".camelize.should == "someStuff"
    end

    it "converts dashed strings into camelized as well" do
      "some-stuff".camelize.should == "someStuff"
    end

    it "handles prefixes correctly" do
      "_some_stuff".camelize.should == "SomeStuff"
    end
  end

  describe '#dasherize' do
    it "converts camelized strings into dashed" do
      "SomeStuff".dasherize.should == "some-stuff"
    end

    it "converts underscored strings into dashed as well" do
      "some_stuff".dasherize.should == "some-stuff"
    end
  end

  describe '#capitalize' do
    it "capitalizes strings" do
      "some stuff".capitalize.should == "Some stuff"
    end
  end

  describe '#starts_with?' do
    it "returns true if a string starts with the substring" do
      "some stuff".starts_with?("some").should == true
    end

    it "returns false if the string doesn't start with the substring" do
      "some stuff".starts_with?("non matching").should == false
    end
  end

  describe '#ends_with?' do
    it "returns true if the string ends with the given substring" do
      "some stuff".ends_with?("stuff").should == true
    end

    it "returns false if the string doesn't end with the substring" do
      "some stuff".ends_with?("non matching").should == false
    end
  end

  describe '#blank?' do
    it "returns true if the string is empty" do
      ''.blank?.should == true
    end

    it "returns true if the string has only white spaces" do
      " \n\t\r ".blank?.should == true
    end

    it "returns false if the string has non-space chars in it" do
      " a ".blank?.should == false
    end
  end

  describe '#constantize' do
    it "returns an object from it's value" do
      "UnderOs::App".constantize.should == UnderOs::App
    end

    it "raises an error if the constant is missing" do
      -> {
        "Something::Totally::Bogus".constantize
      }.should.raise(NameError)
    end
  end

  describe '#to_data' do
    before do
      @data = "ohai there".to_data
    end

    it "converts the string into a data object" do
      @data.is_a?(NSData).should == true
    end

    it "converts it into data with correct content" do
      @data.to_s.should == "ohai there"
    end
  end
end
