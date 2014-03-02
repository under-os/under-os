describe Hash do
  describe '#to_query' do
    it "converts a simple hash into a query string" do
      {a: 1, b: 2}.to_query.should == 'a=1&b=2'
    end

    it "converts nested hashes into queries correctly" do
      {a: 1, b: {c: {d: 4}}}.to_query.should == 'a=1&b%5Bc%5D%5Bd%5D=4'
    end

    it "handles array values correctly" do
      {a: [1,2,3,4]}.to_query.should == 'a%5B%5D=1&a%5B%5D=2&a%5B%5D=3&a%5B%5D=4'
    end

    it "escapes any URL sensitive characters in the values" do
      {a: '%= '}.to_query.should == 'a=%25=%20'
    end
  end
end
