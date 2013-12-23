class JSON
  class Malformed < StandardError ; end

  def self.parse(string, encoding=nil)
    error = Pointer.new(:object)
    data  = NSJSONSerialization.JSONObjectWithData string.to_data(encoding), options:0, error:error

    if error[0]
      raise Malformed
    else
      data
    end
  end

  def self.generate(object, pretty=false)
    options = pretty ? NSJSONWritingPrettyPrinted : 0
    NSJSONSerialization.dataWithJSONObject(object, options:options, error:nil).to_s
  end
end
