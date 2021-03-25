require './lib/tic_tac_toe_v2'

describe Game do
  describe "#check_win" do
    it "determines who the winner is" do
      g = Game.new
      g.board.board[0] = ['X', 'X', 'X']
      g.check_win
      expect(g.winner).to eql(g.p1)
    end
    it "finishes the game when the condition is met" do
      g = Game.new
      g.board.board[0] = ['X', 'X', 'X']
      g.check_win
      expect(g.game_over(g.winner)).to eql(true)
    end
  end
end

describe Player do
  describe "#play_turn" do
    it "places X in case of p1(odd) and places O in case of p2(even)" do
      b = Board.new
      p1 = Player.new(1)
      expect(p1.play_turn(b.board)).to eql('X')
    end
  end 
end

