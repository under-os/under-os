describe "UnderOs::UI::Button" do
  before do
    @button = UnderOs::UI::Button.new(text: "Hello")
  end

  describe "constructor" do
    it "builds an instance of the UnderOs::UI::Button" do
      @button.class.should == UnderOs::UI::Button
    end

    it "wraps an UIButton instance" do
      @button._.class.should == UIButton
    end

    it "assigns the BUTTON tag after it" do
      @button.tagName.should == "BUTTON"
    end
  end

  describe "#text" do
    it "returns the button's label text" do
      @button.text.should == "Hello"
    end

    it "allows to set a new value" do
      @button.text = "New Label"
      @button._.currentTitle.should == "New Label"
    end
  end

  describe '#disabled' do
    it "returns 'false' by default" do
      @button.disabled.should == false
    end

    it "reads the value right of the ios entity" do
      @button._.enabled = false
      @button.disabled.should == true
    end

    it "allows to disable the inputs" do
      @button.disabled = true
      @button._.isEnabled.should == false
    end

    it "has a ruby-style alias" do
      @button.disabled?.should == false
    end
  end
end
