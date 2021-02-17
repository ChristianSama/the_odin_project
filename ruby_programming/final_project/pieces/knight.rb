require_relative 'piece'

class Knight < Piece
  def initialize(color)
    super(color)
    @sprite = @color == 'w' ? '♞' : '♘'
  end
end