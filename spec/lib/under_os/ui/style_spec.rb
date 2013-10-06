describe UnderOs::UI::Style do
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

  describe '#display' do
    it "should return :block by default" do
      @view.style.display.should == :block
    end

    it "should understand the 'none' value" do
      @view.style.display = 'none'
      @view.hidden?.should == true
      @view.style.display.should == :none
    end

    it "should understand the 'block' value" do
      @view.style.display = 'block'
      @view.visible?.should == true
      @view.style.display.should  == :block
    end
  end
end
