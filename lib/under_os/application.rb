class UnderOs::Application
  attr_reader :window

  def self.start(&block)
    @start_block = block
  end

  def initialize(ios_app, options)
    @_      = ios_app
    @window = UnderOs::Window.new

    instance_eval &self.class.instance_variable_get('@start_block')
  end
end
