require_relative '../movement'

class Pawn < Piece
  include Movement

  def initialize(color, position)
    super(color, position)
    @sprite = color == :white ? "\u265f" : "\u2659"
  end

  def get_possible_moves(board)
    possible_moves = []

    front_moves = nil
    num_squares = @has_moved ? 1 : 2
    front_moves = linear_moves(self, [1, 0], num_squares)

    front_moves.each do |move|
      if (board.get_square(move).piece == nil)
        possible_moves << move
      end
    end

    #captures
    captures = linear_moves(self, [1, 1], 1)
    captures += linear_moves(self, [1, -1], 1)

    captures.map! { |e| board.get_square(e).piece}
    captures.compact.each do |piece|
      if (piece.color != @color)
        possible_moves << piece.position
      end
      next
    end

    possible_moves
  end
  
end