describe UnderOs::Page::Builder do
  def build(html)
    UnderOs::Page::Builder.views_from(html)
  end

  describe 'generic build' do
    before do
      @result = build("<view id='my-view'></view>")
    end

    it "should return an array" do
      @result.class.should == Array
    end

    it "should build just one item" do
      @result.size.should == 1
    end

    it "should build an UnderOs::UI::View instance" do
      @result[0].class.should == UnderOs::UI::View
    end

    it "should assign the element properties" do
      @result[0].id.should == 'my-view'
    end
  end

  describe 'types building' do
    it "should build buttons" do
      button = build(%Q{<button class="my-button">Some text</button>})[0]
      button.class.should == UnderOs::UI::Button
      button.classNames.should == ['my-button']
      button.text.should == 'Some text'
    end

    it "should build labels" do
      label = build(%Q{<label>The Text</label>})[0]
      label.class.should == UnderOs::UI::Label
      label.text.should == 'The Text'
    end

    it "should build images" do
      image = build(%Q{<img src="test.png">})[0]
      image.class.should == UnderOs::UI::Image
      image.src.class.should == UIImage
    end

    it "should build icons" do
      icon = build(%Q{<icon type="ok" />})[0]
      icon.class.should == UnderOs::UI::Icon
      icon.type.should == 'ok'
    end
  end

  describe 'nested build' do
    before do
      @result = build(%Q{
        <page id="level1">
          <view id="level2">
            <label>A</label>
            <button>B</button>
          </view>
        </page>
      })[0]
    end

    it "should still assign the top level element attributes" do
      @result.id.should == 'level1'
    end

    it "should build the second level elements" do
      level2 = @result.children
      level2.size.should == 1
      level2[0].id.should == 'level2'
    end

    it "should build the third level of the elements" do
      level3 = @result.children[0].children
      level3.size.should == 2
      level3.map(&:class).should == [UnderOs::UI::Label, UnderOs::UI::Button]
      level3.map(&:text).should == ['A', 'B']
    end
  end

  describe 'selectboxes build' do
    before do
      @result = build(%Q{
        <select>
          <option value="1">One</option>
          <option value="2">Two</option>
          <option>Three</option>
        </select>
      })[0]
    end

    it "should allow to build a select box" do
      @result.class.should == UnderOs::UI::Select
    end

    it "should recognize options" do
      @result.options.should == {
        '1'     => 'One',
        '2'     => 'Two',
        'Three' => 'Three'
      }
    end

    it "should allow to build multi-select boxes" do
      select = build(%Q{
        <select>
          <optgroup>
            <option value="1">One</option>
          </optgroup>
          <optgroup>
            <option value="2">Two</option>
          </optgroup>
          <optgroup>
            <option value="3">Three</option>
          </optgroup>
        </select>
      })[0]

      select.optgroups.should == [
        {'1' => 'One'}, {'2' => 'Two'}, {'3' => 'Three'}
      ]
    end
  end
end
