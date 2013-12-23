describe UnderOS::HTTP::Request do
  before do
    @url     = "http://test.com"
    @request = UnderOS::HTTP::Request.new(@url, {
      headers: {my: 'headers'},
      cookies: {my: 'cookies'},
      params:  {my: 'params'},
      method:  :put
    })
  end

  describe "#constructor" do
    it "assigns the url correctly" do
      @request.url.should == @url
    end

    it "assigns the request headers correctly" do
      @request.headers.should == {my: 'headers'}
    end

    it "assigns the request cookies correctly" do
      @request.cookies.should == {my: 'cookies'}
    end

    it "assigns my params correctly" do
      @request.params.should == {my: 'params'}
    end

    it "assigns the request method correctly" do
      @request.method.should == 'PUT'
    end
  end

  describe "#on" do
    it "returns the response object instead of an event into a callback" do
      @response = nil

      @request.on(:smth) { |r| @response = r }
      @request.emit(:smth, response: 'response')

      @response.should == 'response'
    end
  end
end
