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

  describe '#hasClass' do
    it "should return 'true' if the view has the class" do
      @view.className = 'boo hoo'
      @view.hasClass('boo').should == true
    end

    it "should return false if the view has no class" do
      @view.className = 'boo hoo'
      @view.hasClass('foo').should == false
    end
  end

  describe '#addClass' do
    it "should add the class name if it's missing" do
      @view.addClass 'boo'
      @view.classNames.should == ['boo']
    end

    it "should not duplicat the class if it's already exists" do
      @view.classNames = ['boo']
      @view.addClass 'boo'
      @view.classNames.should == ['boo']
    end

    it "should return the view itself back" do
      @view.addClass('boo').should === @view
    end
  end

  describe '#removeClass' do
    it "should remove the class name if it was set" do
      @view.classNames = ['boo']
      @view.removeClass('boo')
      @view.classNames.should == []
    end

    it "should return the view itself back" do
      @view.removeClass('boo').should === @view
    end
  end

  describe '#toggleClass' do
    it "should add the class if it's missing" do
      @view.toggleClass('test')
      @view.classNames.should == ['test']
    end

    it "should remove the class if was set before" do
      @view.classNames = ['test']
      @view.toggleClass('test')
      @view.classNames.should == []
    end

    it "should return the view itself back" do
      @view.toggleClass('test').should === @view
    end
  end

  describe '#radioClass' do
    before do
      @v1 = UnderOs::UI::View.new.insertTo(@view)
      @v2 = UnderOs::UI::View.new.insertTo(@view)
      @v3 = UnderOs::UI::View.new.insertTo(@view)
    end

    it "should set the class only on one element" do
      @v2.radioClass('boo')

      @v1.hasClass('boo').should == false
      @v2.hasClass('boo').should == true
      @v1.hasClass('boo').should == false
    end

    it "should automatically remove the class from any of the siblings" do
      @v1.className = 'boo'
      @v3.className = 'boo'

      @v2.radioClass('boo')

      @v1.hasClass('boo').should == false
      @v2.hasClass('boo').should == true
      @v1.hasClass('boo').should == false
    end

    it "should return the view itself back" do
      @v2.radioClass('boo').should === @v2
    end
  end
end
