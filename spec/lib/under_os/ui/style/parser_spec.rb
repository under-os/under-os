describe UnderOs::Page::StylesParser do
  before do
    @parser  = UnderOs::Page::StylesParser.new('css')
  end

  it "should parse simple tags" do
    @parser.parse(%Q[
      page {
        background-color: darkgray;
      }
    ]).should == [{
      :rules=>[{:tag=>"page"}],
      :styles=>{"background-color"=>"darkgray"}
    }]
  end

  it "should parse heaps of styles" do
    @parser.parse(%Q{
      button {
        width:         79px;
        height:        79px;
        color:         black;
        background:    white;
        border-radius: 0px;
      }
    }).should == [{
      :rules=>[{:tag=>"button"}],
      :styles=>{"width"=>79.0, "height"=>79.0, "color"=>"black", "background"=>"white", "border-radius"=>0.0}
    }]
  end

  it "should parse classes" do
    @parser.parse(%Q[
      .row1 { bottom: 0px;   }
      .row2 { bottom: 80px;  }

      .col1.col2 { left: 0;  }
    ]).should == [
      {:rules=>[{:class=>["row1"]}], :styles=>{"bottom"=>0.0}},
      {:rules=>[{:class=>["row2"]}], :styles=>{"bottom"=>80.0}},
      {:rules=>[{:class=>["col1", "col2"]}], :styles=>{"left"=>0.0}}
    ]
  end

  it "should parse tags and styles" do
    @parser.parse(%Q[
      button.double { width: 159; }
      button.ops    { background: yellow }
    ]).should == [
      {:rules=>[{:tag=>"button", :class=>["double"]}], :styles=>{"width"=>159.0}},
      {:rules=>[{:tag=>"button", :class=>["ops"]}], :styles=>{"background"=>"yellow"}}
    ]
  end

  it "should parse complex rules" do
    @parser.parse(%Q{
      icon#delete .col1.col2 { color: red }
    }).should == [{
      :rules=>[{:tag=>"icon", :id=>"delete"}, {:class=>["col1", "col2"]}],
      :styles=>{"color"=>"red"}
    }]
  end
end
