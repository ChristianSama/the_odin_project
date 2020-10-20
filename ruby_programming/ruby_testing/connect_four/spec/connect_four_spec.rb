require './lib/connect_four'

describe Player do
  describe "#test" do
    it "test" do
      p = Player.new
      expect(p.test).to eql(false)
    end
  end
end