describe UnderOs::UI::StyleMatcher do
  before do
    @view    = UnderOs::UI::View.new
    @view1   = UnderOs::UI::View.new
    @view2   = UnderOs::UI::View.new
    @matcher = UnderOs::UI::StyleMatcher.new('smth')
  end

  describe '.new' do
    it "should cache instances" do
      @i1 = UnderOs::UI::StyleMatcher.new('.one')
      @i2 = UnderOs::UI::StyleMatcher.new('.one')
      @i3 = UnderOs::UI::StyleMatcher.new('.two')

      @i1.should.be.same_as @i2
      @i1.should.not == @i3
    end
  end

  describe '#match' do
    it "should return 'true' for views with score > 0" do
      def @matcher.score_for(view); 1 end
      @matcher.match(@view).should == true
    end

    it "should return 'false' for views with score == 0" do
      def @matcher.score_for(view); 0 end
      @matcher.match(@view).should == false
    end
  end

  describe '#score_for' do
    def score_for(view, css_rule)
      UnderOs::UI::StyleMatcher.new(css_rule).score_for(view)
    end

    describe 'tags matching' do
      it "should add score for tag match" do
        score_for(@view, 'view').should == 1
      end

      it "should not add score for not matching tags" do
        score_for(@view, 'button').should == 0
      end
    end

    describe 'IDs matching' do
      it "should add score for IDs matches" do
        @view.id = 'my-id'
        score_for(@view, '#my-id').should == 1
      end

      it "should not add score for mismatching IDs" do
        @view.id = 'my-id'
        score_for(@view, '#another-id').should == 0
      end

      it "should not crash if ID is missing" do
        score_for(@view, 'button').should == 0
      end

      it "should not add points if the tag is different" do
        @view.id = 'my-id'
        score_for(@view, 'button#my-id').should == 0
      end
    end

    describe 'class_name matching' do
      it "should add score for matching class names" do
        @view.class_name = 'my-class'
        score_for(@view, '.my-class').should == 1
      end

      it "should not add score for mismatching class names" do
        @view.class_name = 'my-class'
        score_for(@view, '.another-class').should == 0
      end

      it "should add point for every matching class name" do
        @view.class_name = 'class1 class2'
        score_for(@view, '.class1.class2').should == 2
        score_for(@view, '.class2.class1').should == 2
      end

      it "should not add points one of multiple classes don't match" do
        @view.class_name = 'class1 class2'
        score_for(@view, '.class1.class3').should == 0
        score_for(@view, '.class3.class2').should == 0
      end

      it "should not add points if the tag is different" do
        @view.class_name = 'my-class'
        score_for(@view, 'button.my-class').should == 0
      end

      it "should not add points if the ID is different" do
        @view.class_name = 'my-class'
        score_for(@view, '#another-id.my-class').should == 0
      end
    end

    describe 'multiple matches' do
      it "should count in all the matches" do
        @view.id = 'my-id'
        @view.class_name = 'class1 class2'
        score_for(@view, 'view#my-id.class1.class2').should == 4
      end
    end

    describe 'in multi-leveled structures' do
      before do
        @v1 = UnderOs::UI::View.new(class: 'v1')
        @v2 = UnderOs::UI::View.new(class: 'v2')
        @v3 = UnderOs::UI::View.new(class: 'v3')
        @v4 = UnderOs::UI::View.new(class: 'v4')

        @v1.append(@v2.append(@v3.append(@v4.append(@view))))

        @view.id = 'my-view'
      end

      # it "should still match singular rules" do
      #   score_for(@view, '#my-view').should == 1
      # end

      # it "should add points for matching parent" do
      #   score_for(@view, '.v4 #my-view').should     == 2
      #   score_for(@view, 'view.v4 #my-view').should == 3
      # end

      # it "should add multiple points for multiple matching parents" do
      #   score_for(@view, '.v1 .v2 .v3 .v4 #my-view').should == 5
      # end

      it "should match parents at any level" do
        # score_for(@view, '.v3 #my-view').should == 2
        # score_for(@view, '.v2 #my-view').should == 2
        p score_for(@v3, '.v3')
        score_for(@view, '.v1 .v3 #my-view').should == 3
      end

      # it "should return 0 if no matching parent found" do
      #   score_for(@view, '.non-existing #my-view').should == 0
      # end
    end
  end
end
