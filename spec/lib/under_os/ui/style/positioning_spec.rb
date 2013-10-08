describe UnderOs::UI::Style::Positioning do
  before do
    @view  = UnderOs::UI::View.new
    @style = @view.style
  end

  describe '#contentWidth' do
    before do
      @view = UnderOs::UI::Scroll.new
    end

    it "should allow to set the content sizes" do
      @view.style.contentWidth  = 100
      @view.style.contentHeight = 200

      @view.style.contentWidth.should  == 100
      @view.style.contentHeight.should == 200
    end
  end
end
