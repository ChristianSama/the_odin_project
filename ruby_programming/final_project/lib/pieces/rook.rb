require_relative 'piece'

class Rook < Piece
  def initialize(color)
    super(color)
    @sprite = @color == 1 ? '♜' : '♖'
  end
end