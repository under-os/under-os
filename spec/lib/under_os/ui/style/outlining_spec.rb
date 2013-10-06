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
end
