class UnderOs::HTTP
  def self.get(url, options={}, &block)
    request url, options.merge(method: :get), &block
  end

  def self.post(url, options={}, &block)
    request url, options.merge(method: :post), &block
  end

  def self.put(url, options={}, &block)
    request url, options.merge(method: :put), &block
  end

  def self.patch(url, options={}, &block)
    request url, options.merge(method: :patch), &block
  end

  def self.head(url, options={}, &block)
    request url, options.merge(method: :head), &block
  end

  def self.delete(url, options={}, &block)
    request url, options.merge(method: :delete), &block
  end

protected

  def self.request(*args, &block)
    Request.new(*args, &block).send
  end
end
