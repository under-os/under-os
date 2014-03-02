describe UnderOs::UI::Select do
  before do
    @select  = UnderOs::UI::Select.new
  end

  it "inherits fromthe UnderOs::UI::Input" do
    (UnderOs::UI::Select < UnderOs::UI::Input).should == true
  end

  describe '#initialize' do
    it "should make select instances" do
      @select.class.should == UnderOs::UI::Select
    end

    it "should wrap UIPickerView" do
      @select._.class.should == UIPickerView
    end

    it "should have tag SELECT" do
      @select.tagName.should == 'SELECT'
    end

    it "should accept 'options' option" do
      select = UnderOs::UI::Select.new(options: {
        '1' => 'One', '2' => 'Two', '3' => 'Three'
      })

      select.options.should == {
        '1' => 'One', '2' => 'Two', '3' => 'Three'
      }
    end

    it "should accept 'value' option" do
      select = UnderOs::UI::Select.new(value: 1)
      select.value.should == '1'
    end
  end

  describe '#optgroups' do
    it "should return an empty list by default" do
      @select.optgroups.should == [{}]
    end

    it "should allow to assign groups" do
      @select.optgroups = [
        {'1' => 'One'},  {'2' => 'Two'}, {'3' => 'Three'}
      ]

      @select.optgroups.should == [
        {'1' => 'One'},  {'2' => 'Two'}, {'3' => 'Three'}
      ]
    end

    it "should convert keys to strings and skip nils" do
      @select.optgroups = [{
        nil => 'One', :'2' => 'Two', :'3' => nil
      }]

      @select.optgroups.should == [{'2' => 'Two'}]
    end
  end

  describe '#options' do
    it "should return an empty hash by default" do
      @select.options.should == {}
    end

    it "should allow to set new options" do
      @select.options = {
        '1' => 'One', '2' => 'Two', '3' => 'Three'
      }

      @select.options.should == {
        '1' => 'One', '2' => 'Two', '3' => 'Three'
      }
    end

    it "should overwrite the optgroups" do
      @select.options = {
        '1' => 'One', '2' => 'Two', '3' => 'Three'
      }

      @select.optgroups.should == [{
        '1' => 'One', '2' => 'Two', '3' => 'Three'
      }]
    end
  end

  describe '#value' do
    it "should return nil when nothing was set" do
      @select.value.should == nil
    end

    it "should return an empty list if several optgroups were set" do
      @select.optgroups = [
        {'1' => 'One'},  {'2' => 'Two'}, {'3' => 'Three'}
      ]

      @select.value.should == []
    end

    it "should allow to set values for single selects" do
      @select.value = 'one'
      @select.value.should == 'one'
    end

    it "should allow to set values for multi-selects" do
      @select.optgroups = [{'1' => 'One'},  {'2' => 'Two'}]
      @select.value = ['1', '2']
      @select.value.should == ['1', '2']
    end

    it "should convert all values to strings" do
      @select.value = 1
      @select.value.should == '1'
    end

    it "should emit the 'change' event if value was changed" do
      @changed = false
      @select.on(:change) { @changed = true }
      @select.value = 'new'
      @changed.should == true
    end

    it "should not emit the 'change' event if the same value was assigned" do
      @select.value = 'same'

      @changed = false
      @select.on(:change) { @changed = true }
      @select.value = 'same'

      @changed.should == false
    end
  end
end
