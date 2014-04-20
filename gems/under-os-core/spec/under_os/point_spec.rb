describe UnderOs::Point do

  describe '#initialize' do
    it "should eat numbers" do
      point = UnderOs::Point.new(10, 20)
      point.x.should == 10
      point.y.should == 20
    end

    it "should eat hashes" do
      point = UnderOs::Point.new(x: 20, y: 30)
      point.x.should == 20
      point.y.should == 30
    end

    it "should eat hashes with string keys" do
      point = UnderOs::Point.new('x' => 30, 'y' => 40)
      point.x.should == 30
      point.y.should == 40
    end

    it "should eat other opints" do
      other_point = UnderOs::Point.new(x: 40, y: 50)
      new_point   = UnderOs::Point.new(other_point)
      new_point.x.should == other_point.x
      new_point.y.should == other_point.y
    end
  end

  describe '#==' do
    before do
      @point = UnderOs::Point.new(x: 50, y: 60)
    end

    it "should allow comparison to another point" do
      @point.should     == UnderOs::Point.new(x: 50, y: 60)
      @point.should.not == UnderOs::Point.new(x: 60, y: 50)
    end

    it "should allow comparison to a hash" do
      @point.should     == {x: 50, y: 60}
      @point.should.not == {x: 60, y: 50}
    end
  end

  describe '#*' do
    it "should allow to multiply pointers by a factor" do
      point = UnderOs::Point.new(x: 15, y: 25)
      new_point = point * 2
      new_point.should.not == point
      new_point.should == {x: 30, y: 50}
    end
  end

  describe "#+" do
    before do
      @point = UnderOs::Point.new(x: 10, y: 20)
    end

    describe "with another point" do
      before do
        @new_point = @point + UnderOs::Point.new(x: 11, y: 22)
      end

      it "should make an instance of a Point" do
        @new_point.class.should == UnderOs::Point
      end

      it "should apply changes correctly" do
        @new_point.x.should == 21
        @new_point.y.should == 42
      end
    end

    describe "with a number" do
      before do
        @new_point = @point + 4
      end

      it "should make an instance of a Point" do
        @new_point.class.should == UnderOs::Point
      end

      it "should apply changes correctly" do
        @new_point.x.should == 14
        @new_point.y.should == 24
      end
    end

    describe "with a Hash" do
      before do
        @new_point = @point + {x: 6, y: 8}
      end

      it "should make an instance of a Point" do
        @new_point.class.should == UnderOs::Point
      end

      it "should apply changes correctly" do
        @new_point.x.should == 16
        @new_point.y.should == 28
      end
    end
  end

  describe "#-" do
    before do
      @point = UnderOs::Point.new(x: 10, y: 20)
    end

    describe "with another point" do
      before do
        @new_point = @point - UnderOs::Point.new(x: 2, y: 4)
      end

      it "should make an instance of a Point" do
        @new_point.class.should == UnderOs::Point
      end

      it "should apply changes correctly" do
        @new_point.x.should == 8
        @new_point.y.should == 16
      end
    end

    describe "with a number" do
      before do
        @new_point = @point - 4
      end

      it "should make an instance of a Point" do
        @new_point.class.should == UnderOs::Point
      end

      it "should apply changes correctly" do
        @new_point.x.should == 6
        @new_point.y.should == 16
      end
    end

    describe "with a Hash" do
      before do
        @new_point = @point - {x: 6, y: 8}
      end

      it "should make an instance of a Point" do
        @new_point.class.should == UnderOs::Point
      end

      it "should apply changes correctly" do
        @new_point.x.should == 4
        @new_point.y.should == 12
      end
    end
  end
end
