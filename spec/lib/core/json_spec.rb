describe JSON do
  describe ".parse" do
    it "parses correct json strings" do
      JSON.parse('{"a":1,"b":true,"c":["data"]}').should == {
        "a" => 1, "b" => true, "c" => ["data"]
      }
    end

    it "raises an exception on malformed data" do
      -> {
        JSON.parse("malformed")
      }.should.raise(JSON::Malformed)
    end
  end

  describe ".generate" do
    it "generates JSON string out of objects" do
      JSON.generate({a:1, b:true, c:[:data]}).should ==
        '{"a":1,"b":true,"c":["data"]}'
    end

    it "generates pretty print when asked" do
      JSON.generate({a:1, b:true, c:[:data]}, :pretty).should ==
        "{\n  \"a\" : 1,\n  \"b\" : true,\n  \"c\" : [\n    \"data\"\n  ]\n}"
    end

    it "allows to export things directly of objects" do
      {a:1, b:true, c:[:data]}.to_json.should ==
        '{"a":1,"b":true,"c":["data"]}'
    end
  end
end
