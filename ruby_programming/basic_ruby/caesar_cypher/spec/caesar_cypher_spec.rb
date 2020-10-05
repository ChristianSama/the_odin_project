require './lib/caesar_cypher'

describe Cypher do
  describe "#caesar_cypher" do 
    it "shifts a char the given position relative to the alphabet" do
      cypher = Cypher.new
      expect(cypher.caesar_cypher("a", 1)).to eql("b")
    end
    it "it has to wrap from z to a" do
      cypher = Cypher.new
      expect(cypher.caesar_cypher("z", 2)).to eql("b")
    end
    it "has to keep the same case" do
      cypher = Cypher.new
      expect(cypher.caesar_cypher("AaBbCc", 1)).to eql("BbCcDd")
    end
    it "has to ignore spaces" do
      cypher = Cypher.new
      expect(cypher.caesar_cypher("abc def", 1)).to eql("bcd efg")
    end
    it "has to ignore punctuation" do
      cypher = Cypher.new
      expect(cypher.caesar_cypher("abc,.?!-_", 1)).to eql("bcd,.?!-_")
    end
    it "has to ignore numbers" do
      cypher = Cypher.new
      expect(cypher.caesar_cypher("abc 1234", 1)).to eql("bcd 1234")
    end
  end
end