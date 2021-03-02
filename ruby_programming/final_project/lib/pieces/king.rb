require_relative 'piece'

class King < Piece
  def initialize(color, x, y)
    super(color, x, y)
    @sprite = color == :white ? '♚' : '♔'
  end

  def get_possible_moves(board)
    return []
  end
end