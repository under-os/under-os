describe UnderOs::HTTP do
  extend Facon::SpecHelpers

  before do
    @url = 'http://example.com/'
    @req = mock 'request', send: :response
  end

  describe ".get" do
    it "makes a GET request" do
      UnderOs::HTTP::Request.should.receive(:new).
        with(@url, foo: 'bar', method: :get).and_return @req

      UnderOs::HTTP.get(@url, foo: 'bar').should == :response
    end
  end

  describe ".post" do
    it "makes a POST request" do
      UnderOs::HTTP::Request.should.receive(:new).
        with(@url, foo: 'bar', method: :post).and_return @req

      UnderOs::HTTP.post(@url, foo: 'bar').should == :response
    end
  end

  describe ".put" do
    it "makes a PUT request" do
      UnderOs::HTTP::Request.should.receive(:new).
        with(@url, foo: 'bar', method: :put).and_return @req

      UnderOs::HTTP.put(@url, foo: 'bar').should == :response
    end
  end

  describe ".delete" do
    it "makes a DELETE request" do
      UnderOs::HTTP::Request.should.receive(:new).
        with(@url, foo: 'bar', method: :delete).and_return @req

      UnderOs::HTTP.delete(@url, foo: 'bar').should == :response
    end
  end

  describe ".patch" do
    it "makes a DELETE request" do
      UnderOs::HTTP::Request.should.receive(:new).
        with(@url, foo: 'bar', method: :patch).and_return @req

      UnderOs::HTTP.patch(@url, foo: 'bar').should == :response
    end
  end

  describe ".head" do
    it "makes a HEAD request" do
      UnderOs::HTTP::Request.should.receive(:new).
        with(@url, foo: 'bar', method: :head).and_return @req

      UnderOs::HTTP.head(@url, foo: 'bar').should == :response
    end
  end
end
