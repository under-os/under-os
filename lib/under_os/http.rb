class UnderOs::HTTP
  def self.get(url, options={}, &block)
    Request.new(url, options.merge(method: :get), &block).send
  end
end
