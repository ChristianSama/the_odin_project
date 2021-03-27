require_relative '../movement'

class Pawn < Piece
  include Movement

  def initialize(color, position)
    super(color, position)
    @sprite = color == :white ? "\u265f" : "\u2659"
  end

  def get_possible_moves(board)
    
    return moves
  end
  
end