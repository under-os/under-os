describe UnderOs::UI::View do

  describe '#id' do
    it "should allow build views with IDs" do
      view = UnderOs::UI::View.new(id: 'my-view')
      view.id.should == 'my-view'
    end
  end

  describe '#className' do
    it "should allow build views with class names" do
      view = UnderOs::UI::View.new(class: 'my-class another-class')
      view.className.should == 'my-class another-class'
    end
  end
end
