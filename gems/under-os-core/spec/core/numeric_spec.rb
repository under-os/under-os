describe Numeric do

  describe '#milliseconds' do
    it "returns timer duration in milliseconds" do
      10.milliseconds.should == UnderOs::Timer::Duration.new(0.01)
    end

    it "has the 'ms' alias" do
      10.milliseconds.should == 10.ms
    end
  end

  describe '#seconds' do
    it "returns the time duration in seconds" do
      10.seconds.should == UnderOs::Timer::Duration.new(10)
    end
  end

  describe '#minutes' do
    it "returns the time duration in minutes" do
      10.minutes.should == UnderOs::Timer::Duration.new(10 * 60)
    end
  end

  describe '#hours' do
    it "returns the time duration in hours" do
      10.hours.should == UnderOs::Timer::Duration.new(10 * 60 * 60)
    end
  end

  describe '#days' do
    it "returns the time duration in days" do
      10.days.should == UnderOs::Timer::Duration.new(10 * 60 * 60 * 24)
    end
  end

end
