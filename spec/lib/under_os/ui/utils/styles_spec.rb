describe UnderOs::UI::Styles do
  before do
    @view = UnderOs::UI::View.new
  end

  describe '#style' do
    it "should return a style handler for the view" do
      style = @view.style
      style.class.should == UnderOs::UI::Style
      style.view.should.be.same_as @view._
    end

    it "should cache the styles handler instance" do
      @view.style.should.be.same_as @view.style
    end

    it "should allow to set the styles as a hash" do
      @view.style = {top: 10, left: 20}
      @view.style.top.should == 10
      @view.style.left.should == 20
    end
  end

  describe '#classNames' do
    it "should return an empty list by default" do
      @view.classNames.should == []
    end

    it "should allow to assign the lists" do
      @view.classNames = ['one', 'two']
      @view.classNames.should == ['one', 'two']
    end

    it "should remove dups on fly" do
      @view.classNames = ['one', 'two', 'two', 'one']
      @view.classNames.should == ['one', 'two']
    end
  end

  describe '#className' do
    it "should return an empty string by default" do
      @view.className.should == ''
    end

    it "should allow to assign new class names" do
      @view.className = 'one two'
      @view.className.should == 'one two'
      @view.classNames.should == ['one', 'two']
    end
  end
end
