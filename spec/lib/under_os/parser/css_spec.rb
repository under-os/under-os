describe UnderOs::Parser::CSS do
  before do
    @parser  = UnderOs::Parser::CSS.new
  end

  it "should parse simple tags" do
    @parser.parse(%Q[
      page {
        background-color: darkgray;
      }
    ]).should == {'page' => {backgroundColor: "darkgray"}}
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
    }).should == {'button' => {
      width: 79.0, height: 79.0, color: "black", backgroundColor: "white", borderRadius: 0.0
    }}
  end

  it "should parse classes" do
    @parser.parse(%Q[
      .row1 { bottom: 0px;   }
      .row2 { bottom: 80px;  }

      .col1.col2 { left: 0;  }
    ]).should == {
      '.row1' => {bottom: 0.0},
      '.row2' => {bottom: 80.0},
      '.col1.col2' => {left: 0.0}
    }
  end

  it "should parse tags and styles" do
    @parser.parse(%Q[
      button.double { width: 159; }
      button.ops    { background: yellow }
    ]).should == {
      'button.double' => {width: 159.0},
      'button.ops'    => {backgroundColor: "yellow"}
    }
  end

  it "should parse complex rules" do
    @parser.parse(%Q{
      icon#delete .col1.col2 { color: red }
    }).should == {
      'icon#delete .col1.col2' => {color: "red"}
    }
  end
end
