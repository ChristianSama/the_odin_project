require './lib/connect_four'

describe Game do
  describe "#check_win" do
    it "returns true when win condition is met" do
      g = Game.new
      b = Board.new(7, 6)
      b.create_board
      b.board[0][3].fill("x")
      b.board[1][4].fill("x")
      b.board[2][5].fill("x")
      b.board[3][6].fill("x")
      expect(g.check_win(b.board)).to eql(true)
    end
  end
end

