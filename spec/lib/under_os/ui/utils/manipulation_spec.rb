describe UnderOs::UI::Manipulation do
  before do
    @v1 = UnderOs::UI::View.new
    @v2 = UnderOs::UI::View.new
    @v3 = UnderOs::UI::View.new
  end

  describe '#insert' do
    it "should let insert views inside of each other" do
      @v1.insert(@v2)
      @v1.insert(@v3)

      @v1.children.should == [@v2, @v3]
    end

    it "should let insert views on top of the subviews" do
      @v1.insert(@v2)
      @v1.insert(@v3, :top)

      @v1.children.should == [@v3, @v2]
    end

    it "should return the view itself after each operation" do
      @v1.insert(@v2).should == @v1
      @v1.insert(@v3).should == @v1
    end

    it "should accept lists of items" do
      @v1.insert([@v2, @v3])
      @v1.children.should == [@v2, @v3]
    end
  end

  describe '#append' do
    it "should append other views into the current one" do
      @v1.append(@v2)
      @v1.append(@v3)

      @v1.children.should == [@v2, @v3]
    end

    it "should allow to append several views as multiple arguments" do
      @v1.append(@v2, @v3)

      @v1.children.should == [@v2, @v3]
    end

    it "should return the view itself after each operation" do
      @v1.append(@v2).should == @v1
      @v1.append(@v3).should == @v1
    end
  end

  describe '#prepend' do
    it "should put all items on top" do
      @v1.prepend(@v2)
      @v1.prepend(@v3)

      @v1.children.should == [@v3, @v2]
    end

    it "should accept several views as multiple arguments" do
      @v1.prepend(@v2, @v3)

      @v1.children.should == [@v3, @v2]
    end

    it "should return the view itself after each operation" do
      @v1.prepend(@v2).should == @v1
      @v1.prepend(@v3).should == @v1
    end
  end

  describe '#insertTo' do
    it "should allow to insert view into others" do
      @v2.insertTo(@v1)
      @v3.insertTo(@v1)

      @v1.children.should == [@v2, @v3]
    end

    it "should allo to insert intems on top of the stack" do
      @v1.insert(@v2)
      @v3.insertTo(@v1, :top)

      @v1.children.should == [@v3, @v2]
    end

    it "should return the view itself after each operation" do
      @v2.insertTo(@v1).should == @v2
      @v3.insertTo(@v1).should == @v3
    end
  end

  describe '#remove' do
    it "should allow to remove items from superviews" do
      @v1.append(@v2, @v3)

      @v2.remove

      @v1.children.should == [@v3]
    end

    it "should not crash if there is no superviews" do
      @v1.remove
      @v2.remove
      @v3.remove
      true.should == true
    end

    it "should return the view iteslf back" do
      @v1.remove.should == @v1
      @v2.remove.should == @v2
      @v3.remove.should == @v3
    end
  end

  describe '#clear' do
    before { @v1.append(@v2, @v3) }

    it "should remove all the child elements" do
      @v1.clear
      @v1.children.should == []
    end

    it "should return itself back as a reference" do
      @v1.clear.should.be.same_as @v1
    end
  end
end
