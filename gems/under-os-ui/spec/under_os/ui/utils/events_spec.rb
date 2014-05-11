class MyView < UnderOs::UI::View
  attr_reader :args

  def handler_with_event(event)
    @args = [event]
  end

  def handler_without_event
    @args = []
  end
end

describe UnderOs::Event::Gestures::Listener do
  before do
    @view = UnderOs::UI::View.new
  end

  describe "#on" do
    before do
      @tapped = false
      @result = @view.on(:tap) { @tapped = true }

      @view.emit(:tap)
    end

    it "binds the event listener" do
      @tapped.should == true
    end

    it "returns the view object itself back" do
      @result.should.be.same_as @view
    end
  end

  describe "#off" do
    before do
      @tapped = false
      @view.on(:tap) { @tapped = true }

      @result = @view.off(:tap)

      @view.emit(:tap)
    end

    it "un-binds the event listener" do
      @tapped.should == false
    end

    it "returns the view object itself back" do
      @result.should.be.same_as @view
    end
  end

  describe "#emit" do
    before do
      @view.on(:tap) { |e| @event = e }
      @view.emit(:tap, custom: 'param')
    end

    it "emits an UOS::Event" do
      @event.class.should == UnderOs::Event
    end

    it "sets the event target to the view" do
      @event.target.should.be.same_as @view
    end
  end
end
