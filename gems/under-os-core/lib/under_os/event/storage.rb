#
# The callbacks storage, pretty much a private thing
#
module UnderOs::Event::Storage
  extend self

  def list(object, event=nil)
    @listeners ||= Hash.new{|h,k| h[k] = Hash.new{|h,k| h[k] = []} }
    event ? @listeners[object][event.to_sym] : @listeners[object]
  end

  def add(object, event, block)
    list(object, event) << block
  end

  def remove(object, event)
    list(object).delete event.to_sym
  end

  def emit(object, event, params)
    event = UnderOs::Event.new(event, {target: object}.merge(params))

    list(object, event.name).each do |block|
      block.arity == 0 ? block.call : block.call(event)
    end
  end
end
