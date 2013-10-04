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
      @listeners                      ||= {}
      @listeners[model]               ||= {}
      @listeners[model][event.to_sym] ||= [] if event
    end

    def add(model, event, *args, block)
      list(model, event.to_sym) << [block, *args]
      model
    end

    def all(model, event)
      list(model, event.to_sym)
    end

    def remove(model, event)
      list(model).delete event.to_sym
      model
    end

    def kick(model, event, params)
      event = Event.new(event, params) unless event.is_a?(Event)

      all(model, event.name).each do |block, method_name, *args|
        if !block && method_name
          block   = Proc.new{ __send__(method_name, *args) }
          context = model
        elsif block && method_name # <- considering it's a context reference
          context = method_name
        else
          context = nil
        end

        args = block.arity > 0 ? [event] : []

        if context
          context.instance_exec *args, &block
        else
          block.call *args
        end
      end

      model
    end
  end

  class Event
    attr_reader :name, :params

    def initialize(name, params)
      @name   = name.to_sym
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
