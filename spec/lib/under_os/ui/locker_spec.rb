describe UnderOs::UI::Locker do
  before do
    @locker = UnderOs::UI::Locker.new
  end

  describe '#constructor' do
    it "builds locker instances" do
      @locker.class.should == UnderOs::UI::Locker
    end

    it "wraps plain UIView objects" do
      @locker._.class.should == UIView
    end

    it "sets the LOCKER tag" do
      @locker.tagName.should == "LOCKER"
    end

    it "builds the dialog box inside" do
      @locker.first('view.locker-dialog').should.not == nil
      @locker.first('view.locker-dialog spinner').should.not == nil
      @locker.first('view.locker-dialog label').should.not == nil
    end

    it "accepts the label text" do
      locker = UnderOs::UI::Locker.new(text: "Syncing...")
      locker.first('label').text.should == "Syncing..."
      locker.hasClass('with-label').should == true
    end
  end
end
