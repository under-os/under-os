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

  describe '#boxShadow' do
    it "recognizes the x, y values" do
      @view.style.boxShadow = "1px 2px"
      @view.style.boxShadow.should == "1.0 2.0 3.0 0.0 #ff0000"
    end

    it "recognizes the x, y, radius values" do
      @view.style.boxShadow = "-1 -2 4"
      @view.style.boxShadow.should == "-1.0 -2.0 4.0 0.0 #ff0000"
    end

    it "recognizes the x, y, radius, opacity values" do
      @view.style.boxShadow = "4 5 6 7"
      @view.style.boxShadow.should == "4.0 5.0 6.0 7.0 #ff0000"
    end

    it "recognizes the x, y, radius, opacity, color values" do
      @view.style.boxShadow = "4 5 6 7 blue"
      @view.style.boxShadow.should == "4.0 5.0 6.0 7.0 #ff0000"
    end

    it "recognizes the x, y, radius, color values" do
      @view.style.boxShadow = "4 5 6 blue"
      @view.style.boxShadow.should == "4.0 5.0 6.0 0.0 #ff0000"
    end

    it "recognizes the x, y, color values" do
      @view.style.boxShadow = "4 5 green"
      @view.style.boxShadow.should == "4.0 5.0 3.0 0.0 #ff0000"
    end
  end
end
