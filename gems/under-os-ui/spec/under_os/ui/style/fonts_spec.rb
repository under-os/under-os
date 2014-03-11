describe UnderOs::UI::Style::Fonts do
  before do
    @view  = UnderOs::UI::View.new
  end

  describe 'fontFamily' do
    before { @view = UnderOs::UI::Label.new(text: "Hello")}

    it "should return the view's font family name" do
      @view.style.fontFamily.should == @view._.font.familyName
    end

    it "allows to set a new family name" do
      @view.style.fontFamily = "Chalkduster"
      @view._.font.familyName.should == "Chalkduster"
    end

    it "should keep the original font-size" do
      @view.style.fontSize = 20
      @view.style.fontFamily = "Chalkduster"
      @view._.font.pointSize.should == 20.0
    end
  end

  describe "fontSize" do
    before { @view = UnderOs::UI::Label.new(text: "Hello")}

    it "returns the labels current font-size" do
      @view.style.fontSize.should == @view._.font.pointSize
    end

    it "allows to the new font size" do
      @view.style.fontSize = 40
      @view._.font.pointSize.should == 40.0
    end

    it "keeps the original font family" do
      @view.style.fontFamily = "Chalkduster"
      @view.style.fontSize = 30
      @view._.font.familyName.should == "Chalkduster"
    end
  end

  describe 'text-align' do

    it "should not crash when called on unsupported elements" do
      @view.style.textAlign = 'left'
      true.should == true
    end

    describe 'with a label' do
      before do
        @view = UnderOs::UI::Label.new(text: "Hello")
      end

      it "should allow to align the text to the left" do
        @view.style.textAlign = 'left'
        @view._.textAlignment.should == NSTextAlignmentLeft
        @view.style.textAlign.should == 'left'
      end

      it "should allow to align the text to the right" do
        @view.style.textAlign = 'right'
        @view._.textAlignment.should == NSTextAlignmentRight
        @view.style.textAlign.should == 'right'
      end

      it "should allow to align the text to the center" do
        @view.style.textAlign = 'center'
        @view._.textAlignment.should == NSTextAlignmentCenter
        @view.style.textAlign.should == 'center'
      end

      # it "should allow to align the text to fill the size" do
      #   @view.style.textAlign = 'justify'
      #   @view._.textAlignment.should == NSTextAlignmentJustified
      #   @view.style.textAlign.should == 'justify'
      # end
    end

    describe 'with a button' do
      before do
        @view = UnderOs::UI::Button.new(text: "Hello")
      end

      it "should allow to align the text to the left" do
        @view.style.textAlign = 'left'
        @view._.contentHorizontalAlignment.should == UIControlContentHorizontalAlignmentLeft
        @view.style.textAlign.should == 'left'
      end

      it "should allow to align the text to the right" do
        @view.style.textAlign = 'right'
        @view._.contentHorizontalAlignment.should == UIControlContentHorizontalAlignmentRight
        @view.style.textAlign.should == 'right'
      end

      it "should allow to align the text to the center" do
        @view.style.textAlign = 'center'
        @view._.contentHorizontalAlignment.should == UIControlContentHorizontalAlignmentCenter
        @view.style.textAlign.should == 'center'
      end

      it "should allow to align the text to fill the size" do
        @view.style.textAlign = 'justify'
        @view._.contentHorizontalAlignment.should == UIControlContentHorizontalAlignmentFill
        @view.style.textAlign.should == 'justify'
      end
    end
  end
end
