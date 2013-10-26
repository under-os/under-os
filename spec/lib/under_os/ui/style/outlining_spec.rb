describe UnderOs::UI::Style::Outlining do
  before do
    @view  = UnderOs::UI::View.new
    @style = @view.style
  end

  describe '#borderRadius' do
    it "should allow to set it" do
      @style.borderRadius = 10
      @style.borderRadius.should == 10
    end

    it "should change the view's layout property" do
      @style.borderRadius = 20
      @view._.clipsToBounds.should == true
      @view._.layer.cornerRadius.should == 20
    end
  end

  describe '#color' do
    describe 'buttons' do
      before do
        @button = UnderOs::UI::Button.new
      end

      it "should allow to set the colors" do
        @button.style.color = UIColor.redColor
        @button._.titleColorForState(UIControlStateNormal).should == UIColor.redColor
      end

      it "should return the curent button color" do
        @button.style.color = UIColor.yellowColor
        @button.style.color.should == UIColor.yellowColor
      end
    end

    describe 'label' do
      before do
        @label = UnderOs::UI::Label.new
      end

      it "should change the text color" do
        @label.style.color = UIColor.redColor
        @label._.textColor.should == UIColor.redColor
      end

      it "should return the current text color" do
        @label.style.color = UIColor.yellowColor
        @label.style.color.should == UIColor.yellowColor
      end
    end

    describe 'spinner' do
      before do
        @spinner = UnderOs::UI::Spinner.new
      end

      it "should change the color of the spinner" do
        @spinner.style.color = UIColor.redColor
        @spinner._.color.should == UIColor.redColor
      end

      it "should return the current spinner color" do
        @spinner.style.color = UIColor.yellowColor
        @spinner.style.color.should == UIColor.yellowColor
      end
    end
  end
end
