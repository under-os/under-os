class TouchesPage < UOS::Page
  def initialize
    @name   = first("#event-name")
    @num    = first("#touches-num")
    @page_x = first("#pos-x")
    @page_y = first("#pos-y")

    %w[ touchstart touchmove touchend touchcancel ].each do |event|
      view.on(event) { |e| handle(e) }
    end
  end

  def handle(event)
    @name.text   = "Event: #{event.name}"
    @num.text    = "Touches: #{event.touches.size}"
    @page_x.text = "Page X: #{event.touches.map(&:pageX).join(", ")}"
    @page_y.text = "Page Y: #{event.touches.map(&:pageY).join(", ")}"
  end
end
