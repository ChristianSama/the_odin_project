require_relative 'piece'

class Pawn < Piece
  def initialize(color)
    super(color)
    @sprite = @color == 'w' ? '♟︎' : '♙'
  end
end