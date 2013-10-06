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
      @view.hidden.should == true
      @view.style.display.should == :none
    end

    it "should understand the 'block' value" do
      @view.style.display = 'block'
      @view.visible.should == true
      @view.style.display.should  == :block
    end
  end

  describe '#margin' do
    it "should return an array of zeros by default" do
      @style.margin.should == [0, 0, 0, 0]
    end

    it 'should accept simple numbers' do
      @style.margin = 10
      @style.margin.should == [10, 10, 10, 10]
    end

    it "should accept arrays" do
      @style.margin = [20]
      @style.margin.should == [20, 20, 20, 20]
    end

    it "should accept two dim arrays" do
      @style.margin = [10, 20]
      @style.margin.should == [10, 20, 10, 20]
    end

    it "should accept four dims arrays" do
      @style.margin = [10, 20, 30, 40]
      @style.margin.should == [10, 20, 30, 40]
    end

    it "should accept single value strings" do
      @style.margin = '10px'
      @style.margin.should == [10, 10, 10, 10]
    end

    it "should accept two value strings" do
      @style.margin = '10px 20'
      @style.margin.should == [10, 20, 10, 20]
    end

    it "should accept the four values strings" do
      @style.margin = '10px 20 30px 40'
      @style.margin.should == [10, 20, 30, 40]
    end
  end
end
