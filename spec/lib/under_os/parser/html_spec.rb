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
        {tag: "view", attrs: {id: "my-view"}, children: [
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

  it "should handle same tags correctly" do
    parse(%Q{
      <view id="level1">
        <view id='level2'>
          <button>A</button>
          <button>B</button>

          <view id="level3">
            <img src="test.png" />
          </view>

          <view id="level4">
            <icon type="ok">
            <label>A</label>
            <label>B</label>
          </view>
        </view>
      </view>
    }).should == [{
      tag: "view", attrs: {id: "level1"}, children: [
        {tag: "view", attrs: {id: "level2"}, children: [
          {tag: "button", attrs: {}, text: "A"},
          {tag: "button", attrs: {}, text: "B"},

          {tag: "view", attrs: {id: "level3"}, children: [
            {tag: "img", attrs: {src: "test.png"}}
          ]},

          {tag: "view", attrs: {id: "level4"}, children: [
            {tag: "icon", attrs: {type: "ok"}},
            {tag: "label", attrs: {}, text: "A"},
            {tag: "label", attrs: {}, text: "B"}
          ]}
        ]}
      ]}
    ]
  end

  it "should handle multiple single tags correctly" do
    parse(%Q{
      <view>
        <img>
        <icon>
        <slide>
      </view>
      <switch>
      <progress>
    }).should == [
      {tag: "view", attrs: {}, children: [
        {tag: "img", attrs: {}},
        {tag: "icon", attrs: {}},
        {tag: "slide", attrs: {}}
      ]},
      {tag: "switch", attrs: {}},
      {tag: "progress", attrs: {}}
    ]
  end

  it "should skipp all the comments" do
    parse(%Q{
      <view>
        <!-- <img> -->
        <icon>
        <!-- <slide> -->
      </view>
    }).should == [
      {tag: "view", attrs: {}, children: [
        {tag: "icon", attrs: {}}
      ]}
    ]
  end

end
