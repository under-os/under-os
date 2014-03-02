describe UnderOs::Timer do
  describe '#initialize' do
    before do
      @block = Proc.new {}
      @timer = UnderOs::Timer.new(11, repeat: true, &@block)
    end

    it "saves the block" do
      @timer.block.should == @block
    end

    it "sets the interval correctly" do
      @timer.interval.should == 11
    end

    it "sets the repeating cycle correctly" do
      @timer.repeats.should == true
    end
  end

  describe UnderOs::Timer::Duration do
    before do
      @duration = UnderOs::Timer::Duration.new(10)
    end

    it "saves the value in seconds" do
      @duration.seconds.should == 10.0
    end

    it "knows how to convert itself to floats" do
      @duration.to_f.should == 10.0
    end

    it "knows how to convert itself into integers" do
      @duration.to_i.should == 10
    end

    it "knows how to convert itself into strings" do
      @duration.to_s.should == "10.0 seconds"
    end

    it "knows how to compare itself to other durations" do
      @duration.should == UnderOs::Timer::Duration.new(10)
      @duration.should.not == UnderOs::Timer::Duration.new(9)
    end

    describe '#later' do
      before do
        @block = Proc.new {}
        @timer = 10.seconds.later &@block
      end

      it "spawns a timer" do
        @timer.class.should == UnderOs::Timer
      end

      it "spawns one-time timer" do
        @timer.repeats.should == false
      end

      it "spawns a timer with correct interval" do
        @timer.interval.should == 10.0
      end

      it "spawns a timer with correct block to call" do
        @timer.block.should == @block
      end
    end

    describe '#repeat' do
      before do
        @block = Proc.new {}
        @timer = 20.seconds.repeat &@block
      end

      it "spawns a timer" do
        @timer.class.should == UnderOs::Timer
      end

      it "spawns a recursive timer" do
        @timer.repeats.should == true
      end

      it "spawns a timer with correct interval" do
        @timer.interval.should == 20.0
      end

      it "spawns a timer with correct block to call" do
        @timer.block.should == @block
      end
    end
  end
end
