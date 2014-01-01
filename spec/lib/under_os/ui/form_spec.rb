describe "UnderOs::UI::Form" do
  before do
    @form = UnderOs::UI::Form.new
  end

  describe "constructor" do
    it "makes the UnderOs::UI::Form instances" do
      @form.class.should == UnderOs::UI::Form
    end

    it "assigns the FORM tag for the element" do
      @form.tagName.should == "FORM"
    end

    it "takes the usual HTML params" do
      form = UnderOs::UI::Form.new(id: 'my-form')
      form.id.should == 'my-form'
    end
  end

  describe '#elements' do
    before do
      @view   = UnderOs::UI::View.new
      @icon   = UnderOs::UI::Icon.new
      @input  = UnderOs::UI::Input.new
      @button = UnderOs::UI::Button.new

      @form.append @view.append(@icon), @input, @button
    end

    it "returns inputs and buttons" do
      @form.elements.should == [@icon, @input, @button]
    end
  end

  describe "#inputs" do
    it "returns an empty list when there is no input elements" do
      @form.inputs.should == []
    end

    it "returns the list of the input elements only" do
      v1 = UnderOs::UI::View.new
      i1 = UnderOs::UI::Input.new
      i2 = UnderOs::UI::Select.new
      i3 = UnderOs::UI::Switch.new
      i4 = UnderOs::UI::Textarea.new

      @form.append v1.append(i1, i2), i3, i4

      @form.inputs.should == [i1, i2, i3, i4]
    end

    class MyInput1 < UnderOs::UI::Input; end
    class MyInput2 < MyInput1; end

    it "handles subclasses of the inputs as well" do
      i1 = MyInput1.new
      i2 = MyInput2.new
      i3 = UnderOs::UI::Input.new

      @form.append i1, i2, i3

      @form.inputs.should == [i1, i2, i3]
    end
  end

  describe "#values" do
    before do
      @i1 = UnderOs::UI::Input.new(name: 'username', value: 'Nikolay')
      @i2 = UnderOs::UI::Input.new(name: 'password', value: 'TheOsom')

      @form.append @i1, @i2
    end

    it "returns a hash of the values" do
      @form.values.should == {'username' => 'Nikolay', 'password' => 'TheOsom'}
    end

    it "skips inputs without names" do
      @i2.name = nil
      @form.values.should == {'username' => 'Nikolay'}
    end

    it "skips disabled inputs" do
      @i1.disabled = true
      @form.values.should == {'password' => 'TheOsom'}
    end

    it "handles nested hashes in the names" do
      @i1.name = 'user[username]'
      @i2.name = 'user[password]'

      @form.values.should == {'user' => {'username' => 'Nikolay', 'password' => 'TheOsom'}}
    end

    it "handles the array names notation" do
      @i1.name = 'fields[]'
      @i2.name = 'fields[]'

      @form.values.should == {'fields' => ['Nikolay', 'TheOsom']}
    end

    describe 'with a checkbox input' do
      before do
        @checkbox = UnderOs::UI::Switch.new(name: 'isawesome', value: 'true')
        @form.append @checkbox
      end

      it "counts in checkboxes when they're switched on" do
        @checkbox.checked = true
        @form.values.should == {'username' => 'Nikolay', 'password' => 'TheOsom', 'isawesome' => 'true'}
      end

      it "skips the input if it's not ON" do
        @checkbox.checked = false
        @form.values.should == {'username' => 'Nikolay', 'password' => 'TheOsom'}
      end
    end
  end

  describe '#disable' do
    before do
      @icon   = UnderOs::UI::Icon.new
      @input  = UnderOs::UI::Input.new
      @button = UnderOs::UI::Button.new

      @form.append @icon, @input, @button
    end

    it "disabled all the elements on the form" do
      @form.disable

      @icon.disabled.should   == true
      @input.disabled.should  == true
      @button.disabled.should == true
    end
  end

  describe '#enable' do
    before do
      @icon   = UnderOs::UI::Icon.new(disabled: true)
      @input  = UnderOs::UI::Input.new(disabled: true)
      @button = UnderOs::UI::Button.new(disabled: true)

      @form.append @icon, @input, @button
    end

    it "disabled all the elements on the form" do
      @form.enable

      @icon.disabled.should   == false
      @input.disabled.should  == false
      @button.disabled.should == false
    end
  end
end
