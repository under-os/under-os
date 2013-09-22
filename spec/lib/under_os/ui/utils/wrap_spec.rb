describe UnderOs::UI::Wrap do

  describe 'with raw iOS ui instances' do
    def wrap_class_for(raw_class)
      raw = raw_class.alloc.initWithFrame([[0,0],[0,0]])
      UnderOs::UI::View.new(raw).class
    end

    it "should wrap correctly simple views" do
      wrap_class_for(UIView).should == UnderOs::UI::View
    end

    it "should wrap buttons correctly" do
      wrap_class_for(UIButton).should == UnderOs::UI::Button
    end

    it "should wrap labels correctly" do
      wrap_class_for(UILabel).should == UnderOs::UI::Label
    end

    it "should wrap images correctly" do
      wrap_class_for(UIImageView).should == UnderOs::UI::Image
    end

    it "should return the same wrapper for the same uiview all the time" do
      raw  = UIView.alloc.initWithFrame([[0,0],[0,0]])
      inst = UnderOs::UI::View.new(raw)

      UnderOs::UI::View.new(raw).should.be.same_as inst
      UnderOs::UI::View.new(raw).should.be.same_as inst
      UnderOs::UI::View.new(raw).should.be.same_as inst
    end
  end

  describe 'initialization' do
    before do
      @view = UnderOs::UI::View.new
    end

    it "should build a raw uiview object" do
      @view._.class.should == UIView
    end

    it "should register the raw view in the cache" do
      UnderOs::UI::View.new(@view._).should.be.same_as @view
    end
  end

end
