describe UnderOs::UI::Textarea do
  before do
    @textarea = UnderOs::UI::Textarea.new
  end

  it "inherits fromthe UnderOs::UI::Input" do
    (UnderOs::UI::Textarea < UnderOs::UI::Input).should == true
  end

  describe '#initialize' do
    it "should spawn new textareas" do
      @textarea.class.should == UnderOs::UI::Textarea
    end

    it "should wrap the UITextView class" do
      @textarea._.class.should == UITextView
    end

    it "should assign correct tag name" do
      @textarea.tagName.should == 'TEXTAREA'
    end

    it "should accept the 'value' option" do
      textarea = UnderOs::UI::Textarea.new(value: 'boo hoo')
      textarea.value.should == 'boo hoo'
    end

    it "should accept the 'keyboard' option" do
      textarea = UnderOs::UI::Textarea.new(keyboard: 'email')
      textarea.keyboard.should == :email
    end
  end

end
