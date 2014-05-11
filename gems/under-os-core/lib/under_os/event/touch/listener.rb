module UnderOs::Event::Touch::Listener
  def touchesBegan(touches, withEvent:event)
    UnderOs::Event::Touch::Handler.call :touchstart, event
  end

  def touchesMoved(touches, withEvent:event)
    UnderOs::Event::Touch::Handler.call :touchmove, event
  end

  def touchesEnded(touches, withEvent: event)
    UnderOs::Event::Touch::Handler.call :touchend, event
  end

  def touchesCancelled(touches, withEvent:event)
    UnderOs::Event::Touch::Handler.call :touchcancel, event
  end
end
