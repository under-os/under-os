describe UnderOs::Page::Stylesheet do
  before do
    @stylesheet = UnderOs::Page::Stylesheet.new
  end

  describe '#initialize' do
    it "should make an empty stylesheet" do
      @stylesheet.rules.should == {}
    end

    it "should allow initialize with some rules" do
      stylesheet = UnderOs::Page::Stylesheet.new(button: {color: 'orange'})
      stylesheet.rules.should == {'button' => {color: 'orange'}}
    end
  end

  describe '#[]' do
    it "should allow to set new style rules" do
      @stylesheet['button'] = {color: :red}
      @stylesheet['button'].should == {color: :red}
    end

    it "should allow to extend the rules" do
      @stylesheet['button'] = {color: 'red'}
      @stylesheet['button'] = {right:  50  }
      @stylesheet['button'].should == {color: 'red', right: 50}
    end

    it "should overwrite existing rules when match" do
      @stylesheet['button'] = {color: 'red', left: 20}
      @stylesheet['button'] = {color: 'blue'}
      @stylesheet['button'].should == {color: 'blue', left: 20}
    end
  end

  describe '#<<' do
    it "should merge another stylesheet into the current one" do
      other_sytles = UnderOs::Page::Stylesheet.new(button: { color: 'blue' })
      @stylesheet['button'] = {left: 30}
      @stylesheet << other_sytles
      @stylesheet['button'].should == {color: 'blue', left: 30}
    end
  end

  describe '#+' do
    it "should create a new stylesheet combined out of the two" do
      sheet1 = UnderOs::Page::Stylesheet.new(button: { color: 'blue' })
      sheet2 = UnderOs::Page::Stylesheet.new(button: { left: 20 })

      sheet3 = sheet1 + sheet2

      sheet1['button'].should == {color: 'blue'}
      sheet2['button'].should == {left: 20}
      sheet3['button'].should == {color: 'blue', left: 20}
    end
  end

  describe '#load' do
    it "should load rules from the given test stylesheet file" do
      @stylesheet.load('test.css')
      @stylesheet.rules.should == {
        "page"=>{:backgroundColor=>"yellow"},
        ".test"=>{:backgroundColor=>"green"}
      }
    end
  end

  describe '#styles_for' do
    before do
      @view = UnderOs::UI::View.new(class: 'test')
      @stylesheet.load('application.css')
      @stylesheet.load('test.css')
    end

    it "should calculate the styles correctly" do
      @stylesheet.styles_for(@view).should == {
        color:           'yellow',
        backgroundColor: 'green',
        borderRadius:    10
      }
    end
  end

  describe '#apply_to' do
    before do
      @view = UnderOs::UI::View.new(class: 'test')
      @stylesheet.load('test.css')
      @stylesheet.apply_to(@view)
    end

    it "should apply styles to the view" do
      @view.style.backgroundColor.should == UIColor.greenColor
    end
  end
end
