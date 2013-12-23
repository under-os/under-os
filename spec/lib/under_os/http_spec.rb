describe UnderOs::HTTP do
  extend Facon::SpecHelpers

  before do
    @url = 'http://example.com/'
    @req = mock 'request', send: :request
  end

  %w[get post put patch head delete].each do |method|
    describe ".#{method}" do
      it "sends a #{method.upcase} request" do
        UnderOs::HTTP::Request.should.receive(:new)
          .with(@url, foo: 'bar', method: method.to_sym)
          .and_return(@req)

        UnderOs::HTTP.__send__(method, @url, foo: 'bar').should == :request
      end
    end
  end
end
