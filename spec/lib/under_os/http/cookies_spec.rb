describe UnderOS::HTTP::Cookies do
  before do
    @cookies = UnderOS::HTTP::Cookies.new({a: 1, b: true}, "http://test.com")
  end

  it "allows to export them in a string" do
    @cookies.to_s.should == "a=1; b=true"
  end

  it "allows to export them into an HTTP header hash" do
    @cookies.headers.should == {"Cookie"=>"a=1; b=true"}
  end
end
