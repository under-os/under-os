class MyView < UnderOs::UI::View
  attr_reader :args

  def handler_with_event(event)
    @args = [event]
  end

  def handler_without_event
    @args = []
  end
end

describe UnderOs::UI::Events do
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

    it "emits an UI::Event" do
      @event.class.should == UnderOs::UI::Events::Event
    end

    it "sets the event target to the view" do
      @event.target.should.be.same_as @view
    end
  end

  describe "named event handlers" do
    before do
      @view = MyView.new
    end

    it "allows to bind a method by name with an event listener" do
      @view.on :tap, :handler_with_event
      @view.emit(:tap)
      @view.args.size.should == 1
      @view.args[0].class.should == UnderOs::UI::Events::Event
    end

    it "allows to bind a method by name without an event argument" do
      @view.on :tap, :handler_without_event
      @view.emit(:tap)
      @view.args.size.should == 0
    end
  end
end
