class UnderOs::Application
  attr_reader :window

  def self.new(*args)
    @inst ||= super(*args)
  end

  def self.start(&block)
    @inst.instance_eval &block
  end

  def initialize(ios_app, options)
    @_      = ios_app
    @window = UnderOs::Window.new
  end
end
