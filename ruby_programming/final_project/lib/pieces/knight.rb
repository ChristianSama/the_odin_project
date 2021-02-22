require_relative 'piece'

class Knight < Piece
  def initialize(color)
    super(color)
    @sprite = color == :white ? '♞' : '♘'
  end
end