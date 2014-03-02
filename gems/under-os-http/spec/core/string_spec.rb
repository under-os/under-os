describe String do
  describe '#url_encode' do
    it "escapes all the URL sensitive symbols" do
      "!*'\"();:@&=+$,/?%#[]% ".url_encode.should == "!*'%22();:@&=+$,/?%25%23%5B%5D%25%20"
    end

    it "doesn't touch normal characters" do
      "Hello World".url_encode.should == "Hello%20World"
    end
  end

  describe '#url_decode' do
    it "converts an url encoded string back to normality" do
      "!*'%22();:@&=+$,/?%25%23%5B%5D%25%20".url_decode.should == "!*'\"();:@&=+$,/?%#[]% "
    end

    it "doesn't break normal characters" do
      "Hello%20World".url_decode.should == "Hello World"
    end
  end
end
