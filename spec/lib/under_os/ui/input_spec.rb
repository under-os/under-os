describe UnderOs::UI::Input do
  before do
    @input = UnderOs::UI::Input.new
  end

  describe '#initialize' do
    it "should spawn new inputs" do
      @input.class.should == UnderOs::UI::Input
    end

    it "should wrap the UITextField class" do
      @input._.class.should == UITextField
    end

    it "should assign correct tag name" do
      @input.tagName.should == 'INPUT'
    end

    it "should accept the 'name' option" do
      input = UnderOs::UI::Input.new(name: 'some_name')
      input.name.should == 'some_name'
    end

    it "should accept the 'value' option" do
      input = UnderOs::UI::Input.new(value: 'boo hoo')
      input.value.should == 'boo hoo'
    end

    it "should accept the 'placeholder' option" do
      input = UnderOs::UI::Input.new(placeholder: 'enter here')
      input.placeholder.should == 'enter here'
    end

    it "should accept the 'keyboard' option" do
      input = UnderOs::UI::Input.new(keyboard: 'email')
      input.keyboard.should == :email
    end
  end

  # describe '#type' do
  #   it "should handle the 'password' type correctly" do
  #     @input.type = 'password'
  #     @input._.secureTextEntry.should == true
  #   end

  #   it "should convert the input type back" do
  #     @input.type = 'password'
  #     @input.type.should == 'password'
  #   end

  #   it "should return 'text' by default" do
  #     @input.type.should == 'text'
  #   end
  # end

  describe '#name' do
    it "should assign the name to an input field" do
      @input.name = 'newname'
      @input.name.should == 'newname'
    end
  end

  describe '#value' do
    it "should assign the value to the wrapped element" do
      @input.value = 'new value'
      @input._.text.should == 'new value'
    end
  end

  describe '#placeholder' do
    it "should assign the placeholder property on the wrapped element" do
      @input.placeholder = 'tap here'
      @input._.placeholder.should == 'tap here'
    end
  end

  describe '#keyboard' do
    it "should allow to assign keyboard types" do
      @input.keyboard = :url
      @input._.keyboardType.should == UIKeyboardTypeURL
    end

    it "should convert the keybaord types back to symbolic name in the getter" do
      @input.keyboard = :email
      @input.keyboard.should == :email
    end
  end

end
