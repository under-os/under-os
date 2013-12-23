class UnderOs::HTTP
  def self.get(url, options={}, &block)
    request url, options.merge(method: :get)
  end

  def self.post(url, options={}, &block)
    request url, options.merge(method: :post)
  end

  def self.put(url, options={}, &block)
    request url, options.merge(method: :put)
  end

  def self.patch(url, options={}, &block)
    request url, options.merge(method: :patch)
  end

  def self.head(url, options={}, &block)
    request url, options.merge(method: :head)
  end

  def self.delete(url, options={}, &block)
    request url, options.merge(method: :delete)
  end

protected

  def self.request(*args, &block)
    Request.new(*args, &block).send
  end
end
