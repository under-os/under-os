describe UnderOs::UI::Spinner do
  before do
    @spinner = UnderOs::UI::Spinner.new
  end

  describe 'constructor' do
    it "should build a spinner" do
      @spinner.class.should == UnderOs::UI::Spinner
    end

    it "should wrap the UIActivityIndicatorView" do
      @spinner._.class.should == UIActivityIndicatorView
    end

    it "should have the correct tag name" do
      @spinner.tagName.should == 'SPINNER'
    end

    it "should make it spin" do
      @spinner.visible.should == true
    end
  end

  describe '#show' do
    # it "should start the spinner" do
    #   @spinner.show
    #   @spinner._.isAnimating.should == 1
    # end

    it "should return the spinner back" do
      @spinner.should.be.same_as @spinner
    end
  end

  describe '#hide' do
    # it "should stop the spinner" do
    #   @spinner.hide
    #   @spinner._.isAnimating.should == 0
    # end

    it "should return the spinner instance back" do
      @spinner.hide.should.be.same_as @spinner
    end
  end

  describe '#hidden' do
    # it "should return false when the spinner is active" do
    #   @spinner.show
    #   @spinner.hidden.should == false
    # end

    # it "should return true when the spinner is inactive" do
    #   @spinner.hide
    #   @spinner.hidden.should == true
    # end
  end
end
