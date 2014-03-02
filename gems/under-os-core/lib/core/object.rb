class Object
  def to_json(pretty=nil)
    JSON.generate(self, pretty)
  end
end
