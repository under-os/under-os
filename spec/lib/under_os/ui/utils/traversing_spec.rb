describe UnderOs::UI::Traversing do

  before do
    @v1 = UnderOs::UI::View.new
    @v2 = UnderOs::UI::View.new
    @v3 = UnderOs::UI::View.new
    @v4 = UnderOs::UI::View.new
    @v5 = UnderOs::UI::View.new
    @v6 = UnderOs::UI::View.new

    @v1.append(
      @v2.append(
        @v3,
        @v4.append(
          @v5.append(
            @v6
    ))))

    @v2.className = 'v1 v2'
    @v3.className = 'v1 v3'
    @v4.className = 'v3 v4'
    @v5.className = 'v5'
    @v6.className = 'v6'
  end

  describe '#find' do
    it "should return a list of matching items from all levels" do
      @v1.find('.v1').should == [@v2, @v3]
      @v1.find('.v3').should == [@v3, @v4]
    end

    it "should return an empty list when nothing's found" do
      @v1.find(".non-existing").should == []
    end
  end

  describe '#first' do
    it "should return the first correctly matching view" do
      @v1.first('.v1').should == @v2
      @v1.first('.v3').should == @v3
    end

    it "should return nil when nothing matching found" do
      @v1.first('.non-existing').should == nil
    end
  end

  describe '#matches' do
    it "should return 'true' when it's given a matching css-rule" do
      @v2.matches('.v2').should == true
    end

    it "should return 'false' when it's given a non-matching css-rule" do
      @v2.matches('.something-else').should == false
    end
  end

  describe '#parent' do
    it "should be nil by default" do
      @v1.parent.should == nil
    end

    it "should return the correct view if the parent is set" do
      @v2.parent.should == @v1
    end

    it "should search for a matching parent if a css-rule was specified" do
      @v6.parent('.v4').should == @v4
      @v6.parent('.v2').should == @v2
    end

    it "should return nil if a css-rule was specified and nothing matches" do
      @v6.parent('.non-existing').should == nil
    end
  end

  describe '#children' do
    it "should return an empty array by default" do
      @v6.children.should == []
    end

    it "should return the list of children when there are some" do
      @v1.children.should == [@v2]
      @v2.children.should == [@v3, @v4]
    end

    it "should filter the list by a css-rule if one was given" do
      @v2.children('.v4').should == [@v4]
      @v2.children('.non-existing').should == []
    end

    it "should return an empty list on leaf elements like buttons" do
      UnderOs::UI::Image.new.children.should == []
    end
  end

  describe '#siblings' do
    it "should return the list of sibling nodes" do
      @v3.siblings.should == [@v4]
      @v4.siblings.should == [@v3]
    end

    it "should accept a css rule as a filter" do
      @v3.siblings('.v4').should == [@v4]
      @v3.siblings('.non-existing').should == []
    end

    it "should fall back to an empty list when there is no parent" do
      UnderOs::UI::View.new.siblings.should == []
    end
  end

  describe '#empty?' do
    it "should return true when there is no child elements" do
      view = UnderOs::UI::View.new
      view.empty?.should == true
    end

    it "should return false when there are child elements" do
      @v1.empty?.should == false
    end
  end

end
