#
# A little events handling concern
#
module UnderOs::Events

  def on(event, *args, &block)
    Listeners.add(self, event, *args, block)
  end

  def no(event)
    Listeners.remove(self, event)
  end

  def emit(event, params={})
    Listeners.kick(self, event, params)
  end

  module Listeners
    extend self

    def list(model, event=nil)
      @listeners               ||= {}
      @listeners[model]        ||= {}
      @listeners[model][event] ||= [] if event
    end

    def add(model, event, *args, block)
      list(model, event) << [block, *args]
      model
    end

    def all(model, event)
      list(model, event)
    end

    def remove(model, event)
      list(model).delete event
      model
    end

    def kick(model, event, params)
      event = Event.new(event, params) unless event.is_a?(Event)

      all(model, event.name).each do |block, context, method_name|
        context ||= model
        block = Proc.new{ |event| __send__(method_name, event) } if !block && method_name
        context.instance_exec event, &block
      end

      model
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
