describe UnderOs::Page::Style do
  before do
    @page  = TestPage.new
    @style = UnderOs::Page::Styles.new(@page)
  end

  describe '#initialize' do
    it "should load the application stylesheets" do
      @style.instance_variable_get('@rules')[:app].should == {
        "page"      => {:background=>"white"},
        ".test"     => {:background=>"blue", :borderRadius=>5.0, :color=>"yellow"},
        "view.test" => {:borderRadius=>10.0}
      }
    end

    it "should load the page related stylesheets" do
      @style.instance_variable_get('@rules')[:page].should == {
        "page"  => {:background=>"yellow"},
        ".test" => {:background=>"pink"}
      }
    end
  end

  describe '#calculate_for' do
    before do
      @view = UnderOs::UI::View.new(class: 'test')
    end

    it "should calculate the styles correctly" do
      @style.calculate_for(@view).should == {
        color:        'yellow',
        background:   'pink',
        borderRadius: 10
      }
    end
  end



end
