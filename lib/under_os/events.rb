#
# A little events handling concern
#
module UnderOs::Events

  def on(event, &block)
    Listeners.add(self, event, block)
  end

  def no(event)
    Listeners.remove(self, event)
  end

  def emit(event, params={})
    event = Event.new(event, params) unless event.is_a?(Event)

    Listeners.all(self, event.name).each do |block|
      instance_exec event, &block
    end
  end

  module Listeners
    extend self

    def list(model, event=nil)
      @listeners               ||= {}
      @listeners[model]        ||= {}
      @listeners[model][event] ||= [] if event
    end

    def add(model, event, block)
      list(model, event) << block
    end

    def all(model, event)
      list(model, event)
    end

    def remove(model, event)
      list(model).delete event
    end
  end

  class Event
    attr_reader :name, :params

    def initialize(name, params)
      @name   = name
      @params = params
    end

    def method_missing(name, *args, &block)
      if @params.has_key?(name.to_sym)
        @params[name.to_sym]
      else
        super name, *args, &block
      end
    end
  end

end
