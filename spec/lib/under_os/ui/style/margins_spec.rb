describe UnderOs::UI::Style::Margins do
  before do
    @view  = UnderOs::UI::View.new
    @style = @view.style
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
