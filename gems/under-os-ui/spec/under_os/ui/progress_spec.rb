describe UnderOs::UI::Progress do
  before do
    @progress = UnderOs::UI::Progress.new
  end

  describe '#initialize' do
    it "should build a spinner" do
      @progress.class.should == UnderOs::UI::Progress
    end

    it "should wrap the UIProgressView" do
      @progress._.class.should == UIProgressView
    end

    it "should have the correct tag name" do
      @progress.tagName.should == 'PROGRESS'
    end

    it "should accept the 'value' option" do
      progress = UnderOs::UI::Progress.new(value: 0.4)
      progress.value.should == 0.4
    end
  end

  describe '#value' do
    it "should assign values correctly" do
      @progress.value = 0.6
      @progress._.progress.should == 0.6
    end
  end
end
