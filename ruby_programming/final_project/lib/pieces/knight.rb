require_relative 'piece'

class Knight < Piece
  def initialize(color, x, y)
    super(color, x, y)
    @sprite = color == :white ? '♞' : '♘'
  end
end