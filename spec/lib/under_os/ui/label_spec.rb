describe UnderOs::UI::Label do
  describe '#initialize' do
    it "should spawn new inputs" do
      label = UnderOs::UI::Label.new
      label.class.should == UnderOs::UI::Label
    end

    it "should wrap the UILabel class" do
      label = UnderOs::UI::Label.new
      label._.class.should == UILabel
    end

    it "should accept the 'text' option" do
      label = UnderOs::UI::Label.new(text: 'label text')
      label.text.should == 'label text'
    end
  end
end
