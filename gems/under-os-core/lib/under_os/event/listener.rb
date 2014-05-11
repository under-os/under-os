#
# The basic event listener concern
#
# Usage:
#
#     class MyStuff
#       include UnderOs::Event::Listener
#
#       def initialize
#         on(:smth) { do_stuff }
#       end
#     end
#
module UnderOs::Event::Listener

  def on(event, &block)
    UnderOs::Event::Storage.add(self, event, block)
    self
  end

  def off(event)
    UnderOs::Event::Storage.remove(self, event)
    self
  end

  def emit(event, params={})
    UnderOs::Event::Storage.emit(self, event, params)
    self
  end

end
