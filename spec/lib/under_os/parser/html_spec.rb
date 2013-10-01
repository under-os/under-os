describe UnderOs::Parser::HTML do

  def parse(src)
    @parser ||= UnderOs::Parser::HTML.new
    @parser.parse(src)
  end

  it "should parse simple tags" do
    parse(%Q{
      <page>
        asdf
      </page>
    }).should == [{
      tag:   'page',
      text:  'asdf',
      attrs: {}
    }]
  end

  it "should parse tag attributes" do
    parse(%Q{
      <page title="My Page" id='my-page'>
      </page>
    }).should == [{
      tag:  'page',
      text: '',
      attrs: {
        title: "My Page",
        id:    "my-page"
      }
    }]
  end

  it "should process nested views" do
    parse(%Q{
      <page>
        <view id="my-view">
          <view class="my-view">
          </view>
        </view>
      </page>
    }).should == [{
      tag: "page", attrs: {}, children: [
        {tag: "view", attrs: {id: "my-view"}, :children=>[
          {tag: "view", attrs: {class: "my-view"}}
        ]}
      ]
    }]
  end

  it "should handle terminal nodes correctly" do
    parse(%Q{
      <page>
        <img src="my-image.jpg" />
        <button>Boo Hoo</button>
      </page>
    }).should == [{
      tag: "page", attrs: {}, children: [
        {tag: "img", attrs: {src: "my-image.jpg"}},
        {tag: "button", attrs: {}, text: "Boo Hoo"}
      ]
    }]
  end


end
