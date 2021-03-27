require_relative '../movement'

class Knight < Piece
  include Movement

  def initialize(color, position)
    super(color, position)
    @sprite = color == :white ? "\u265e" : "\u2658"
  end

  def get_possible_moves(board)
    possible_moves = []
      moves = knight_moves(self)
      moves.each do |move|
        piece = board.get_square(move).piece
        if (piece != nil)
          if (piece.color != @color)
            possible_moves << move
          end
          next
        end
        possible_moves << move
      end
    possible_moves
  end
end