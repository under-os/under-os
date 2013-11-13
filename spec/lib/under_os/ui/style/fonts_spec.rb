describe UnderOs::UI::Style::Fonts do
  before do
    @view  = UnderOs::UI::View.new
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
