describe UnderOs::Parser do

  it "should parse .css files" do
    UnderOs::Parser.parse('test.css').size.should.not == 0
  end

  it "should parse .html files" do
    UnderOs::Parser.parse('test.html').size.should.not == 0
  end

  it "should not fail on non existing files" do
    UnderOs::Parser.parse('non-existing.css').should  == {}
    UnderOs::Parser.parse('non-existing.html').should == []
  end

end
