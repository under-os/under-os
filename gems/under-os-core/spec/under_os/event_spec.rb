describe UnderOs::Event::Listener do
  class Dummy
    include UnderOs::Event::Listener
  end

  before do
    @dummy = Dummy.new
  end

  describe "#on" do
    it "should add event listeners" do
      @dummy.on(:smth) { }
      UnderOs::Event::Storage.list(@dummy, :smth).size.should == 1
    end

    it "should return the object itself back" do
      @dummy.on(:smth) { }.should.be.same_as @dummy
    end
  end

  describe "#off" do
    it "should remove event listeners" do
      @dummy.on(:smth) { }
      @dummy.off(:smth)
      UnderOs::Event::Storage.list(@dummy, :smth).size.should == 0
    end

    it "should return the object itself back" do
      @dummy.off(:smth).should.be.same_as @dummy
    end
  end

  describe "#emit" do
    it "should emit events" do
      kicked = false
      @dummy.on(:smth) { kicked = true }
      @dummy.emit(:smth)
      kicked.should == true
    end

    it "should return the object itself back" do
      @dummy.emit(:smth).should.be.same_as @dummy
    end

    it "should accept optional params" do
      event = nil
      @dummy.on(:smth) { |e| event = e }
      @dummy.emit(:smth, param1: 1, param2: 2)
      event.params.should == {param1: 1, param2: 2, target: @dummy}
    end
  end

  describe 'UnderOs::Event' do
    before do
      @event = UnderOs::Event.new(:event_name, param1: 1, param2: 2)
    end

    it "should give access to it's name" do
      @event.name.should == :event_name
    end

    it "should give access to it's params" do
      @event.params.should == {param1: 1, param2: 2}
    end

    it "should magically pass all the missing requests to the params" do
      @event.param1.should == 1
      @event.param2.should == 2
    end
  end
end
