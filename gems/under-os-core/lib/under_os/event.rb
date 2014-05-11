#
# Generic event class for all sorts of events handling
#
class UnderOs::Event
  attr_reader :name, :params

  def initialize(name, params)
    @name   = name
    @params = params
  end

  def method_missing(name, *args, &block)
    if @params.has_key?(name)
      @params[name]
    else
      super name, *args, &block
    end
  end
end
