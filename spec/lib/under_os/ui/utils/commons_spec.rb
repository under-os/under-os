describe UnderOs::UI::Commons do
  before do
    @view = UnderOs::UI::View.new
  end

  describe '#id' do
    it "should allow build views with ids" do
      view = UnderOs::UI::View.new(id: 'my-id')
      view.id.should == 'my-id'
    end

    it "should allow to change the id" do
      view = UnderOs::UI::View.new(id: 'old-id')
      view.id = 'new-id'
      view.id.should == 'new-id'
    end
  end

  describe '#data' do
    it "should allow to specify the data hash with views constructor" do
      view = UnderOs::UI::View.new(data: {my: 'data'})
      view.data.should == {my: 'data'}
    end

    it "should allow to assign the new data" do
      view = UnderOs::UI::View.new(data: {old: 'data'})
      view.data = {new: 'data'}
      view.data.should == {new: 'data'}
    end
  end

  describe '#hidden?' do
    it "shoudl return 'false' for visible views" do
      @view.hidden?.should == false
    end

    it "should return 'true' for hidden views" do
      @view._.hidden = true
      @view.hidden?.should == true
    end
  end

  describe '#visible?' do
    it "should return 'true' if the element's visible" do
      @view.visible?.should == true
    end

    it "should return 'false' if the element's is hidden" do
      @view._.hidden = true
      @view.visible?.should == false
    end
  end
end
