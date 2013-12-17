class UnderOs::HTTP
  def self.get(url, options={}, &block)
    Request.new(url, options.merge(method: :get), &block).send
  end

  def self.post(url, options={}, &block)
    Request.new(url, options.merge(method: :post), &block).send
  end

  def self.put(url, options={}, &block)
    Request.new(url, options.merge(method: :put), &block).send
  end

  def self.delete(url, options={}, &block)
    Request.new(url, options.merge(method: :delete), &block).send
  end

  def self.patch(url, options={}, &block)
    Request.new(url, options.merge(method: :patch), &block).send
  end

  def self.head(url, options={}, &block)
    Request.new(url, options.merge(method: :head), &block).send
  end
end
