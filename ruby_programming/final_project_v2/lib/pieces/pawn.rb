require_relative '../movement'

class Pawn < Piece
  include Movement

  attr_accessor :en_passant_capture, :en_passant_piece

  def initialize(color, position = nil)
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

    #en passant capture
    if en_passant_capture != nil
      possible_moves << en_passant_capture 
    end

    possible_moves
  end
  
end