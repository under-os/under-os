module UnderOs::Event::Touch::Handler
  extend self

  def list
    @list ||= Hash.new{ |h,k| h[k] = []}
  end

  def add(event, target)
    list[event] << target
  end

  def call(event_name, native_event)
    list[event_name].each do |target|
      target_touches = touches_for(target._, native_event)

      if target_touches.size > 0
        target.emit(event_name, touches: target_touches, native: native_event)
      end
    end
  end

private

  def touches_for(target, event)
    [].tap do |touches|
      frame = target.frame

      event.allTouches.each do |touch|
        position = touch.locationInView(nil)

        if position_overlaps_with(frame, position)
          touches << UnderOs::Event::Touch.new(position, frame.origin)
        end
      end
    end
  end

  def position_overlaps_with(frame, position)
    position.x > frame.origin.x &&
    position.y > frame.origin.y &&
    position.x < frame.origin.x + frame.size.width &&
    position.y < frame.origin.y + frame.size.height
  end
end
