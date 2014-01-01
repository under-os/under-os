describe UnderOs::Page::StylesMatcher do
  before do
    @view    = UnderOs::UI::View.new
    @view1   = UnderOs::UI::View.new
    @view2   = UnderOs::UI::View.new
    @matcher = UnderOs::Page::StylesMatcher.new('smth')
  end

  describe '.new' do
    it "should cache instances" do
      @i1 = UnderOs::Page::StylesMatcher.new('.one')
      @i2 = UnderOs::Page::StylesMatcher.new('.one')
      @i3 = UnderOs::Page::StylesMatcher.new('.two')

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
      UnderOs::Page::StylesMatcher.new(css_rule).score_for(view)
    end

    describe 'tags matching' do
      it "should add score for tag match" do
        score_for(@view, 'view').should == 1
      end

      it "should not add score for not matching tags" do
        score_for(@view, 'button').should == 0
      end

      it "should not add score if the id is wrong" do
        score_for(@view, 'view#some-id').should == 0
      end

      it "should not add score if the css-rule is wrong" do
        score_for(@view, 'view.some-class').should == 0
      end

      it "should handle the * as the tag name" do
        score_for(@view, '*').should == 1
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

    describe 'className matching' do
      it "should add score for matching class names" do
        @view.className = 'my-class'
        score_for(@view, '.my-class').should == 1
      end

      it "should not add score for mismatching class names" do
        @view.className = 'my-class'
        score_for(@view, '.another-class').should == 0
      end

      it "should add point for every matching class name" do
        @view.className = 'class1 class2'
        score_for(@view, '.class1.class2').should == 2
        score_for(@view, '.class2.class1').should == 2
      end

      it "should not add points one of multiple classes don't match" do
        @view.className = 'class1 class2'
        score_for(@view, '.class1.class3').should == 0
        score_for(@view, '.class3.class2').should == 0
      end

      it "should not add points if the tag is different" do
        @view.className = 'my-class'
        score_for(@view, 'button.my-class').should == 0
      end

      it "should not add points if the ID is different" do
        @view.className = 'my-class'
        score_for(@view, '#another-id.my-class').should == 0
      end
    end

    describe "attribute matchers" do
      before do
        @view.id = "my-view"
      end

      def score_for(view, css_rule)
        UnderOs::Page::StylesMatcher.new(css_rule).score_for(view)
      end

      describe "with the '=' operator" do
        it "scores when the value matches exactly" do
          score_for(@view, '[id="my-view"]').should == 1
        end

        it "doesn't count when the value does not match" do
          score_for(@view, "[id='my']").should == 0
        end
      end

      describe "with the '*=' operator" do
        it "scores when the attribute includes the value" do
          score_for(@view, '[id*=vie]').should == 1
        end

        it "doesn't count when the value doesn't match attribute" do
          score_for(@view, '[id*=mismatch]').should == 0
        end
      end

      describe "with the ^= operator" do
        it "scores when the attribute starts with the value" do
          score_for(@view, '[id^=my]').should == 1
        end

        it "doesn't count when the attribute doesn't start with the value" do
          score_for(@view, '[id^=view]').should == 0
        end
      end

      describe "with the $= operator" do
        it "scores when the attribute ends with the value" do
          score_for(@view, '[id$=view]').should == 1
        end

        it "doesn't count when the attribute doesn't ends with the value" do
          score_for(@view, '[id$=my]').should == 0
        end
      end

      describe "with the ~= operator" do
        before { @view.id = "one two three" }

        it "scores when the value is a token from the attribute" do
          score_for(@view, '[id~=one]').should == 1
          score_for(@view, '[id~=two]').should == 1
          score_for(@view, '[id~=three]').should == 1
        end

        it "doesn't trigger on completely different strings" do
          score_for(@view, '[id~=four]').should == 0
        end

        it "doesn't trigger on partial substrings" do
          score_for(@view, '[id~=tw]').should == 0
        end
      end

      describe "with the |= operator" do
        it "scores when value is a dashed token of the attribute" do
          score_for(@view, '[id|=my]').should == 1
          score_for(@view, '[id|=view]').should == 1
        end

        it "doesn't trigger on completely different values" do
          score_for(@view, '[id|=mismatch]').should == 0
        end

        it "doesn't trigger on partial matches" do
          score_for(@view, '[id|=vie]').should == 0
        end
      end
    end

    describe 'multiple nested matches' do
      it "should count in all the matches" do
        @view.id = 'my-id'
        @view.className = 'class1 class2'
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

      it "should still match singular rules" do
        score_for(@view, '#my-view').should == 1
      end

      it "should add points for matching parent" do
        score_for(@view, '.v4 #my-view').should     == 2
        score_for(@view, 'view.v4 #my-view').should == 3
      end

      it "should add multiple points for multiple matching parents" do
        score_for(@view, '.v1 .v2 .v3 .v4 #my-view').should == 5
      end

      it "should match parents at any level" do
        score_for(@view, '.v3 #my-view').should == 2
        score_for(@view, '.v2 #my-view').should == 2
        score_for(@view, '.v1 .v3 #my-view').should == 3
      end

      it "should return 0 if no matching parent found" do
        score_for(@view, '.non-existing #my-view').should == 0
      end
    end

    describe "multiple different matchers" do
      before do
        @view.id        = 'my-view'
        @view.className = 'classy'
      end

      it "gets score out of multiple matchers if one of them is matching" do
        score_for(@view, "view, input, form").should == 1
      end

      it "return 0 if none of the matchers are matching" do
        score_for(@view, "input,select").should == 0
      end

      it "gets the max score if there are multiple matches" do
        score_for(@view, "view,.classy,view#my-view").should == 2
      end
    end
  end
end
